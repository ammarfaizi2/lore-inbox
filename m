Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVHXVc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVHXVc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVHXVc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:32:58 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:55795 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S932259AbVHXVc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:32:57 -0400
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F043851AD@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F043851AD@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <95AE7798-CD53-4BEA-99F4-88FC5B475614@freescale.com>
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "Gala Kumar K.-galak" <galak@freescale.com>,
       <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       <linux-ia64@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH 05/15] ia64: remove use of asm/segment.h
Date: Wed, 24 Aug 2005 16:32:59 -0500
To: "Luck, Tony" <tony.luck@intel.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Aug 24, 2005, at 3:19 PM, Luck, Tony wrote:

>> There are still a few drivers that include asm/segment.h, so
>> I don't think we should remove asm/segment.h itself just yet.
>>
>
> Agreed.  The sequence should be to send patches to get rid of
> all "#include <asm/segment.h>" references.
>
> Once they have all gone, then a patch can remove the files.
>
> If you are concerned that people would start adding new
> references and you don't want to get into a game of whack-a-mole,
> then you could add #warning "include of deprecated asm/segment.h",
> but that might be overkill.
>
> I'll apply this for ia64 w/o the deletion.

I've posted a patch before this to remove all non-architecture users  
of asm/segment.h.

http://www.ussg.iu.edu/hypermail/linux/kernel/0508.3/0099.html

- kumar



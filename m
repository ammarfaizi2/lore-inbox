Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbVKBFQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbVKBFQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 00:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbVKBFQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 00:16:55 -0500
Received: from dvhart.com ([64.146.134.43]:33194 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751506AbVKBFQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 00:16:54 -0500
Date: Tue, 01 Nov 2005 21:16:59 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Roland Dreier <rolandd@cisco.com>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Subject: Re: [PATCH] x86_64: Work around Re: 2.6.14-git1 (and -git2) build failure on AMD64
Message-ID: <231750000.1130908618@[10.10.2.4]>
In-Reply-To: <52br17nfmk.fsf@cisco.com>
References: <16080000.1130681008@[10.10.2.4]> <200510301649.42064.ak@suse.de> <52br17nfmk.fsf@cisco.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Roland Dreier <rolandd@cisco.com> wrote (on Sunday, October 30, 2005 08:17:39 -0800):

>     Andi> Linus, can you please apply it?
> 
> No, please don't apply this.  The correct fix is to mark
> toshiba_ohci1394_dmi_table[] as __devinitdata in that file, as in the
> patch I posted here:
> 
>     http://lkml.org/lkml/2005/10/29/12

Tested, fixes it for me. Linus - this is still broken in -git4, any chance
you could pick this one up? Makes nasty red marks across my shiny green
test matrix ;-)

Thanks,

M.



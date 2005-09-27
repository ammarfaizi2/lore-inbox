Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965186AbVI0WEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbVI0WEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbVI0WEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:04:22 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:24782 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S965187AbVI0WEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:04:21 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pci_ids.h: cleanup: whitespace and remove unused entries
Date: Wed, 28 Sep 2005 08:04:05 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <rhejj1pbo1am80scv5mn6un0ts7jj1ksev@4ax.com>
References: <937ti1hpvcjdk8hf894h651s81nu6il239@4ax.com> <20050926213557.GA21973@kroah.com> <4339B83C.9020103@pobox.com>
In-Reply-To: <4339B83C.9020103@pobox.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005 17:23:08 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:

>Greg KH wrote:
[...]
>>               We should start by removing the pci device and vendor ids
>> that are not currently used by the kernel, and then slowly move those
>> ids into the individual drivers, starting with the device ids, and maybe
>> eventually moving to the vendor ids.
>
>The vendor ids are OBVIOUSLY common constants.  The proper place is 
>where they live now:  pci_ids.h.
>
>I see little value in moving referenced device ids into individual 
>drivers, as they will make them harder to grep for, as time passes.

Hi Jeff,
Couple weeks ago you wrote:
 >Long term, we should be able to trim a lot of device ids, since they are 
 >usually only used in one place.

What did you mean here?  Trim from where?

Currently I have about 2011 symbols in the source, and 2040 in pci_ids.h, 
with about 15 duplicates (likely the macro #define ones).  

The situation is like the donkey between the hay bales.

Which way?

In meantime I'll continue to document current practice here:
  http://bugsplatter.mine.nu/kernel/pci_ids/

Thanks,
Grant.


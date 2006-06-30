Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWF3BJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWF3BJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 21:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWF3BJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 21:09:28 -0400
Received: from web33514.mail.mud.yahoo.com ([68.142.206.163]:18596 "HELO
	web33514.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750752AbWF3BJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 21:09:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=mRI/rriYuw1sxA1vBoA+ORw3jd73N6yEOfE/kwV84L+lcYdHgcPoK2b8e3viBhM7IC5Gn7T4wVbEZjMKdsN+5BQUcondaioX8nssL5wCeSDjRV4Iz4+QZts529f7iihcw5EMa/gZ2sCkW89nsxxB/39jVx2ZlB8E84GbZhkY8VY=  ;
Message-ID: <20060630010926.15679.qmail@web33514.mail.mud.yahoo.com>
Date: Thu, 29 Jun 2006 18:09:26 -0700 (PDT)
From: Narendra Hadke <nhadke@yahoo.com>
Subject: Re: sata_mv driver on 88sx6041 (kernel version 2.6.14)
To: linux-kernel@vger.kernel.org
Cc: nhadke@yahoo.com
In-Reply-To: <4496B47B.7070602@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got it working. Thanks.
This works in PIO mode hence performance is horrible.
I see the udma mode is set to 0 in driver 2.6.14
sata_mv version 0.12.  Is is possible to Back port
sata_mv from versin 2.6.17 to 2.6.14 to get a stable
drive. 
   Please let me know.
Thanks,
Narendra 

--- Mark Lord <lkml@rtr.ca> wrote:

> Narendra Hadke wrote:
> > Hi,
> > I am using sata_mv driver as exists in kernel
> 2.6.13,
> > reached to a stage where after detecting the disk,
> > control gets struck. Any ideas? 
> 
> No surprises there.  The sata_mv driver is horribly
> buggy
> in all kernels prior to 2.6.16, and even there it
> still has
> some serious bugs.  The 2.6.17 kernel version is
> MUCH better.
> 
> Cheers
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

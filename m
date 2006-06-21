Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWFUAN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWFUAN5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWFUAN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:13:56 -0400
Received: from web33513.mail.mud.yahoo.com ([68.142.206.162]:42910 "HELO
	web33513.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932159AbWFUAN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:13:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=e3oU6fHkpkT+HrSyG5BrZMGfoFwf8JSCL5TuisQiOygE15oWdcsG67MmWZF0eZguz9bRRIZLhme8EWluNbpG98C97ofZjRoy6uFHg2bDC2knWm4XUd8j09PJSLlnGpBKe5Af+iN43q3kHmsgo/S0Xi36PSDqQpy6GYrdeM8Pizc=  ;
Message-ID: <20060621001355.31529.qmail@web33513.mail.mud.yahoo.com>
Date: Tue, 20 Jun 2006 17:13:55 -0700 (PDT)
From: Narendra Hadke <nhadke@yahoo.com>
Subject: Re: sata_mv driver on 88sx6041 (kernel version 2.6.13)
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4496B47B.7070602@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  In the latest driver sata_mv for 88SX6041, the disk
 is detected but I don't see any attachs happening on 
 this disk ie. something like this.
  Attaching :scsi sda sda1 sda2
    Did I miss anything in kernel configs?  
Thanks
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

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268474AbUJOVTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268474AbUJOVTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 17:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268457AbUJOVTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 17:19:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:19906 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268447AbUJOVSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 17:18:55 -0400
Date: Fri, 15 Oct 2004 14:18:09 -0700
From: Greg KH <greg@kroah.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: root@chaos.analogic.com, David Woodhouse <dwmw2@infradead.org>,
       Josh Boyer <jdub@us.ibm.com>, gene.heskett@verizon.net,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>
Subject: Re: Fw: signed kernel modules?
Message-ID: <20041015211809.GA27783@kroah.com>
References: <27277.1097702318@redhat.com> <Pine.LNX.4.61.0410150723180.8573@chaos.analogic.com> <1097843492.29988.6.camel@weaponx.rchland.ibm.com> <200410151153.08527.gene.heskett@verizon.net> <1097857049.29988.29.camel@weaponx.rchland.ibm.com> <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com> <1097860121.13633.358.camel@hades.cambridge.redhat.com> <Pine.LNX.4.61.0410151319460.6877@chaos.analogic.com> <1097873791.5119.10.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097873791.5119.10.camel@krustophenia.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 04:56:33PM -0400, Lee Revell wrote:
> On Fri, 2004-10-15 at 13:35, Richard B. Johnson wrote:
> > You just don't get it. This is policy.
> > 
> > Script started on Fri 15 Oct 2004 01:13:59 PM EDT
> > # insmod xxx.ko
> > xxx: module license 'BSD' taints kernel.
> > # exit
> > Script done on Fri 15 Oct 2004 01:14:26 PM EDT
> 
> OK, now _this_ is undeniably policy, I would go so far as to call it
> bullshit.  There is a fundamental technical reason to have closed source
> modules taint the kernel, because you cannot debug a closed source
> module.

If you have a BSD licensed module, you do not have to provide the source
code for it.

Dual BSD/GPL licensed modules do not change the taint flag.

greg k-h

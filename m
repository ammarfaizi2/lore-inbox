Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVEEUyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVEEUyc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 16:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVEEUyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 16:54:32 -0400
Received: from animx.eu.org ([216.98.75.249]:37515 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262189AbVEEUya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 16:54:30 -0400
Date: Thu, 5 May 2005 16:53:51 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /proc/ide/hd?/settings obsolete in 2.6.
Message-ID: <20050505205351.GC17861@animx.eu.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050505004854.GA16550@animx.eu.org> <58cb370e050505031041c2c164@mail.gmail.com> <20050505111324.GA17223@animx.eu.org> <58cb370e050505051360d0588c@mail.gmail.com> <1115304977.23360.83.camel@localhost.localdomain> <20050505153807.GB17724@animx.eu.org> <1115310081.19842.89.camel@localhost.localdomain> <20050505163316.GB17861@animx.eu.org> <1115315925.19842.92.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115315925.19842.92.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2005-05-05 at 17:33, Wakko Warner wrote:
> > Now, i have programs that I can't tell it the geometry (which it does use
> > and requires to be correct.  My guesses using edd are correct).  I was using
> > /proc/ide/hdX/settings to tell the kernel what geometry I want so the
> > programs that can only ask the kernel can get it right.
> 
> And the geometry ioctls are obsolete for the applications too.

What is the right way for apps that need it to get it?  Or is the kernel
just going to obsolete geometry entirely?

> > If the "right" way is via IOCTL, my scripts are written in perl that do the
> > bulk of the guess work.
> 
> I suspect it is for other programs that are still using that geometry
> data and
> really mkdosfs is what needs fixing ?

mkdosfs definately needs fixing.  I intend on filing a bug report about
this.

If I knew more about the dos format, I might not even have to do this.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals

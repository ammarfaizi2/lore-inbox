Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbUKWCLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbUKWCLz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbUKWCJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:09:33 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:34826 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262457AbUKWCJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:09:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dKylSohfta5Fqbs80Y0GCULifjYo1FVHq8JKigS+5JtaVSjHjqlhr7Gtm8DmYD6mvqvZsw6TieV8T13P0XOS04Zy0QMoHz5F7F7e1ufSHIVMTLNEsvpdRAogMZIZIEu2MRs/95R+6D2N1zbp9m6nOZ5lUbe9+Wb6LwtC1tq134I=
Message-ID: <88652ca704112218082aad1db7@mail.gmail.com>
Date: Mon, 22 Nov 2004 18:08:59 -0800
From: Bob van Manen <bobm75@gmail.com>
Reply-To: Bob van Manen <bobm75@gmail.com>
To: Greg KH <greg@kroah.com>, Matt Heler <lkml@lpbproductions.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6. 9-gentoo-r4 migration kernel thread is using 10-60% cpu
In-Reply-To: <20041122225822.GF15634@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <88652ca704112212541b530efc@mail.gmail.com>
	 <200411221455.12234.lkml@lpbproductions.com>
	 <20041122225822.GF15634@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me check into this a little further. I just did a reboot and
couldn't reproduce it as easily. I've installed the vanilla 2.6.9
kernel to compare behavior.

thanks

bob


On Mon, 22 Nov 2004 14:58:22 -0800, Greg KH <greg@kroah.com> wrote:
> On Mon, Nov 22, 2004 at 02:55:11PM -0700, Matt Heler wrote:
> > Have you made an attempt to contact the gentoo kernel team ? As it's probally
> > some patch they tacked onto there kernel release that's causing you issues.
> 
> Based on the patches that Gentoo adds to their 2.6 kernel, I really
> doubt it.  There are no scheduling patches in their patchset.
> 
> You can browse the patches online, here's the link to their latest
> patchset:
>         http://genpatches.bkbits.net:8080/genpatches/src/genpatches-2.6-9.06?nav=index.html|src/
> 
> thanks,
> 
> greg k-h
>

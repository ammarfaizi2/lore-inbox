Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288557AbSATXCZ>; Sun, 20 Jan 2002 18:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288733AbSATXCQ>; Sun, 20 Jan 2002 18:02:16 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:32780 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288557AbSATXCC>;
	Sun, 20 Jan 2002 18:02:02 -0500
Date: Sun, 20 Jan 2002 14:57:38 -0800
From: Greg KH <greg@kroah.com>
To: David Weinehall <tao@acc.umu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 18, 2002
Message-ID: <20020120225737.GB27088@kroah.com>
In-Reply-To: <3C477B7F.22875.11D4078A@localhost> <m1zo39grhm.fsf@frodo.biederman.org> <20020120133745.C1735@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020120133745.C1735@khan.acc.umu.se>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 23 Dec 2001 19:50:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2002 at 01:37:45PM +0100, David Weinehall wrote:
> 
> Unless it's already in there:
> 
> * Sort out which USB UHCI-driver to keep (UHCI or UHCI-JE)

Odds are it will be neither :)
(The uhci.c driver will mutate into a uhci-hcd driver, and then the
uhci.c and usb-uhci.c drivers will go away.)

There's a start of a Linux USB TODO available at:
	http://www.linux-usb.org/2.5_todo.php

It needs to be flushed out and added to, but at least it's a start.

thanks,

greg k-h

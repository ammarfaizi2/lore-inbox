Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264656AbSJTWxZ>; Sun, 20 Oct 2002 18:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264660AbSJTWxY>; Sun, 20 Oct 2002 18:53:24 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:16000 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S264656AbSJTWxY>;
	Sun, 20 Oct 2002 18:53:24 -0400
Date: Sun, 20 Oct 2002 17:58:54 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: steve roemen <steve.roemen@wcom.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 PIIX4 ide oops on boot
In-Reply-To: <005201c27887$e95f7320$e70a7aa5@WSXA7NCC106.wcomnet.com>
Message-ID: <Pine.LNX.4.44.0210201757470.860-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, steve roemen wrote:

> 
> attached is the oops, the config,  and some info on the box.
> 
> ide is only used for the cdrom.
> 
> it oopes during bootup.  also, if i remove ide from this kernel, it'll boot
> on the scsi drive just fine.
> 
> 2.4.19 works just fine on this box.

Your config says you have ide-cd configured.  Try taking just ide-cd out 
and reboot.  I've found a problem with 2.5.44 and ide-cd on my system 
also.  I have a similar oops on boot or module insertion.


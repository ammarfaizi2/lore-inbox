Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbUBVBNr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 20:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbUBVBNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 20:13:47 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:40715 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261637AbUBVBNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 20:13:45 -0500
Date: Sun, 22 Feb 2004 02:13:44 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Steve Kieu <haiquy@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-mjb1  vmware modules compile error..
Message-ID: <20040222011344.GB7483@vana.vc.cvut.cz>
References: <20040222005721.60222.qmail@web10410.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222005721.60222.qmail@web10410.mail.yahoo.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 11:57:21AM +1100, Steve Kieu wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> I can not compile vmware modules in kernel 2.6.3-mjb1
> the compilation bomb wiht lot of error ; it can not
> find out many header files, probably something changes
> in the kernel build
> system?
> 
> The vmmon modules I got from thi site
> ftp://platan.vc.cvut.cz/pub/vmware/ version 51
> (latest). vmnet compile
> fine.

It would be nice if you could post beginning of the compilation
messages. It uses simple 

$(DRIVER_KO):
        make -C $(BUILD_DIR) SUBDIRS=$$PWD SRCROOT=$$PWD/$(SRCROOT) modules

to start build, so I have no idea why it should break on your system.
							Petr


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031336AbWLEUoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031336AbWLEUoK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031339AbWLEUoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:44:10 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:56017 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031332AbWLEUoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:44:07 -0500
Date: Tue, 5 Dec 2006 21:39:57 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Marty Leisner <linux@rochester.rr.com>, linux-kernel@vger.kernel.org,
       bug-cpio@gnu.org, martin.leisner@xerox.com
Subject: Re: ownership/permissions of cpio initrd
In-Reply-To: <4575D7F4.3060707@mnsu.edu>
Message-ID: <Pine.LNX.4.61.0612052139180.18570@yvahk01.tjqt.qr>
References: <200612052024.kB5KOY1o023781@laptop13.inf.utfsm.cl>
 <4575D7F4.3060707@mnsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It appears to not be standard with fedora for sure... but while it origiginally
> was/is a Debian package it looks like there is source if you'd like to build it
> on other systems.  It was originally designed to tackle the exact problem you
> are confronting.
>
> See:
> http://freshmeat.net/projects/fakeroot/
>
> About:
> Fakeroot runs a command in an environment were it appears to have root
> privileges for file manipulation, by setting LD_PRELOAD to a library with
> alternative versions of getuid(), stat(), etc. This is useful for allowing
> users to create archives (tar, ar, .deb .rpm etc.) with files in them with root
> permissions/ownership. Without fakeroot one would have to have root privileges
> to create the constituent files of the archives with the correct permissions
> and ownership, and then pack them up, or one would have to construct the
> archives directly, without using the archiver.

Ugh that sounds even more than a hack. At least for one-user 
archives, I guess nobody at Debian knows that tar has a --user and 
--group option.


	-`J'
-- 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbVJEXXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbVJEXXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 19:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbVJEXXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 19:23:37 -0400
Received: from free.hands.com ([83.142.228.128]:13752 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S1030431AbVJEXXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 19:23:36 -0400
Date: Thu, 6 Oct 2005 00:23:30 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: David Leimbach <leimy2k@gmail.com>
Cc: Bodo Eggert <7eggert@gmx.de>, Nix <nix@esperi.org.uk>,
       Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005232330.GS10538@lkcl.net>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <3e1162e60510050755l590a696bx655eb0b7ac05aab6@mail.gmail.com> <Pine.LNX.4.58.0510051744480.2279@be1.lrz> <3e1162e60510050941l55485cbdgf6135e314a015d8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1162e60510050941l55485cbdgf6135e314a015d8f@mail.gmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 1) make namespaces joinable in a sane way
> > 2) wait for the shared subtree patch
> > 3) make pam join the per-user-namespace
> > 4) make pam automount tmpfs on the private /tmp
 
 per-user namespaces on /tmp would solve a lot of the problems faced by
 selinux with respect to directory permissions on /tmp/.font-unix
 and /tmp/.X11-unix.
 
 there are a lot of legacy apps that no-one wants to modify to get them
 to create/read /tmp/x-windows/.X11-unix.

 oops.


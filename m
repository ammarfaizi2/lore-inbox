Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267709AbUBTHoo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 02:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267728AbUBTHoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 02:44:44 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:36841 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S267709AbUBTHom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 02:44:42 -0500
X-Analyze: Velop Mail Shield v0.0.3
Date: Fri, 20 Feb 2004 04:44:40 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: linux-kernel@vger.kernel.org
cc: linux-hotplug-devel@lists.sourceforge.net
Subject: Re: HOWTO use udev to manage /dev
In-Reply-To: <Pine.LNX.4.58.0402192306110.694@pervalidus.dyndns.org>
Message-ID: <Pine.LNX.4.58.0402200435140.1167@pervalidus.dyndns.org>
References: <20040219185932.GA10527@kroah.com> <20040219191636.GC10527@kroah.com>
 <Pine.LNX.4.58.0402191918440.688@pervalidus.dyndns.org> <20040219230749.GA15848@kroah.com>
 <Pine.LNX.4.58.0402192033490.694@pervalidus.dyndns.org> <20040219235602.GI15848@kroah.com>
 <Pine.LNX.4.58.0402192057590.694@pervalidus.dyndns.org> <20040220015433.GC3134@kroah.com>
 <Pine.LNX.4.58.0402192306110.694@pervalidus.dyndns.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed I had a lot of devices created by udev in the disk
(in /dev), including /dev/null, so I removed all, but it
obviously didn't work anymore because without /dev/console init
complains, doesn't start, and reboots.

I guess it isn't that easy to use devfs without any devices in
the disk ?

I'll readd /dev/console.

-- 
http://www.pervalidus.net/contact.html

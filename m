Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTKBX42 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 18:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTKBX42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 18:56:28 -0500
Received: from smtp803.mail.ukl.yahoo.com ([217.12.12.140]:20603 "HELO
	smtp803.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261872AbTKBX41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 18:56:27 -0500
Subject: ALSA (snd-via82xx) + 2.4 kernel + VAIO laptops w/VIA VT82C686
From: Lars Peterson <peterson@cs.uwp.edu>
Reply-To: peterson@cs.uwp.edu
To: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Warren Togami <warren@togami.com>
Content-Type: text/plain
Organization: 
Message-Id: <1067817384.31747.223.camel@mango.larspeterson.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Nov 2003 17:56:24 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I struggled with getting ALSA sound to work on my Sony VAIO PCG-FXA49
until I googled this workaround:
http://lists.freshrpms.net/pipermail/rpm-list/2002-November/002250.html

My laptop hard locks upon trying to load the snd-via82xx module UNLESS
the OSS via82cxx_audio module has already been loaded & unloaded.

Warren suggested that I report this to those responsible for maintaining
the 2.4 and ALSA, since he claims the problem appears to have gone away
in post 2.5.47-ac4 kernels.

Environment:
Gentoo Linux 1.4
Kernel 2.4.22-ck2
Alsa-{drivers,utils,lib,tools}-0.9.8

Hardware:
1.2 GHz AMD Athlon 4
512MB SDRAM
VIA KT133/KM133 Chipset

Please cc responses to me as I'm not subscribed to either list.

Lars Peterson


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbSLINbT>; Mon, 9 Dec 2002 08:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbSLINbT>; Mon, 9 Dec 2002 08:31:19 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:700 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265457AbSLINbS>; Mon, 9 Dec 2002 08:31:18 -0500
Subject: Re: /proc/pci deprecation?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Henderson <rth@twiddle.net>, Patrick Mochel <mochel@osdl.org>,
       Willy Tarreau <willy@w.ods.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
In-Reply-To: <Pine.LNX.4.44.0212081747590.1209-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0212081747590.1209-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Dec 2002 14:14:21 +0000
Message-Id: <1039443261.10551.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A PS to this btw reading over the code - currently it seems to write it
with our IRQ data if we do a suspend/resume but not initially. If so we
have an inconsistency to resolve


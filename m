Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbTLRXVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 18:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265397AbTLRXVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 18:21:39 -0500
Received: from CM-vina5-170-70.cm.vtr.net ([200.104.170.70]:43136 "EHLO
	127.0.0.1") by vger.kernel.org with ESMTP id S265395AbTLRXVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 18:21:37 -0500
Subject: Re: FrameBuffer Problem With 2.6.0
From: "Davidlohr Bueso A." <dbueso@linuxchile.cl>
Reply-To: dbueso@linuxchile.cl
To: Armin <Zoup@zoup.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200312182329.36227.Zoup@zoup.org>
References: <200312181254.23501.Zoup@zoup.org>
	 <1071740125.852.69.camel@winsucks>  <200312182329.36227.Zoup@zoup.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Daemon Technologies
Message-Id: <1071789758.917.6.camel@offworld>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Dec 2003 20:22:38 -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-19 at 05:29, Armin wrote:

> i have compile kernel with vga fonts , Still are not working ... 

I had the same problem, I compiled 2.6.0 with vga fonts and It worked
just fine. This is some of my .config that might intrest you

CONFIG_INPUT=y
CONFIG_VT=y
CONFIG_VGA_CONSOLE=y
CONFIG_VT_CONSOLE=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_ACORN_8x8=y
CONFIG_FONT_MINI_4x6=y

	dave

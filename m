Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWCaROc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWCaROc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWCaROb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:14:31 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:65461 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S1750772AbWCaROb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:14:31 -0500
Date: Fri, 31 Mar 2006 19:14:18 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Jeff Dike <jdike@karaya.com>, Gerd Knorr <kraxel@strusel007.de>
Cc: linux-kernel@vger.kernel.org
Subject: x11-fb driver
Message-ID: <20060331171418.GG2542@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

here's an updated patch of Gerd Knorr's x11-fb patch, taken from here: 
http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.16/patches/x11-fb

It compiles on 2.6.16 and works at least a little bit. I get some
initial output, see the screenshot here:

http://www.pengutronix.de/uml-x11.gif

However, the window is never redrawn and I didn't manage to make input
working, but it may be a start for others. It was a little bit messy to
find the right kconfig switches which had to be enabled, because the
uml's kconfig structure is very different from the mainstream one. 

Gerd, are you still actively working on this driver?

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


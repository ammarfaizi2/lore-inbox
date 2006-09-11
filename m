Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWIKGSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWIKGSK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 02:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWIKGSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 02:18:10 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:30596 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964913AbWIKGSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 02:18:09 -0400
Date: Mon, 11 Sep 2006 08:16:28 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Menuconfig won't draw lines on my terminal?
In-Reply-To: <200609110152_MC3-1-CAD7-1E87@compuserve.com>
Message-ID: <Pine.LNX.4.61.0609110815260.14570@yvahk01.tjqt.qr>
References: <200609110152_MC3-1-CAD7-1E87@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Using PuTTY as SSH client, I get ASCII chars instead of lines when
>I use menuconfig:

Have you set your locale correctly? Have you set up PUTTY correctly?
(Works For Me)


>This happens on both Fedora Core 2 and 5.  Midnight Commander draws lines,
>so I know the characters are in the font.

MC uses SLang, others use ncurses. Check $TERM and compare with your 
putty configuration.



Jan Engelhardt
-- 

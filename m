Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263948AbUDFSkh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbUDFSkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:40:36 -0400
Received: from pra68-d23.gd.dial-up.cz ([193.85.68.23]:31105 "EHLO
	penguin.localdomain") by vger.kernel.org with ESMTP id S263948AbUDFSkd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:40:33 -0400
Date: Tue, 6 Apr 2004 20:40:00 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: menuconfig and UTF-8
Message-ID: <20040406184000.GB3770@penguin.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040404122426.GA16383@penguin.localdomain> <20040405212148.GA2387@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405212148.GA2387@mars.ravnborg.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 11:21:48PM +0200, Sam Ravnborg wrote:
> On Sun, Apr 04, 2004 at 02:24:26PM +0200, Marcel Sebek wrote:
> > Hi.
> > 
> > I'm using UTF-8 and new changes in Makefile (2.6.5-rc3/2.6.5-final)
> > broke using menuconfig on linux console (xterm works ok).
> 
> Could you please explain how it 'broke' menuconfig.
> It works for me, but I have no fancy locale setup.
> 

I have LC_CTYPE=en_US.UTF-8. No LC_ALL or other locale variables set.
I run unicode_start on console and then menuconfig stops working right.
It prints ISO-8859-1 chars to UTF-8 terminal, which causes incorrect
indentation (UTF-8 has multi byte chars) and absence of frames.

I cannot get screenshot from console because I don't use framebuffer
and in xterm it works correctly (don't know why).

-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E


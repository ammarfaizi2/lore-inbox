Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271245AbTG2F01 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 01:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271262AbTG2F01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 01:26:27 -0400
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:9180 "HELO
	trinity-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S271245AbTG2F00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 01:26:26 -0400
X-Analyze: Velop Mail Shield v0.0.3
Date: Tue, 29 Jul 2003 02:26:24 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: Re: PS/2 mouse and 2.6.0-test2
Message-ID: <Pine.LNX.4.56.0307290218120.131@pervalidus.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I read someone got it to work as a module, so I'll likely try
> that tomorrow.

No luck. I compiled all mouse drivers as modules and tried
modprobe mousedev
modprobe psmouse
gpm -m /dev/misc/psaux (or the /dev/input devices) -t ps/2

Same 'Lost synchronization' messages and the crazy (optical)
mouse. No keys pressed, it moves very fast if you move if
slightly, pastes text, executes any gpm -S commands, and on
XFree86 opens rxvt etc.

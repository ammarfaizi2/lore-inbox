Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272043AbTG2TSV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272042AbTG2TSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:18:21 -0400
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:25231 "HELO
	trinity-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S272006AbTG2TSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:18:17 -0400
X-Analyze: Velop Mail Shield v0.0.3
Date: Tue, 29 Jul 2003 16:17:57 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
cc: Adam Voigt <adam@cryptocomm.com>
Subject: Re: kernel-2.6.0-test2 speedy gonzalez mouse
Message-ID: <Pine.LNX.4.56.0307291534540.278@pervalidus.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.6.0-test2 works great for me, with the exception of the
> mouse, which seems to have been hyper-accelerated by the
> kernel upgrade. I've had to turn the mouse speed and
> acceleration to the very lowest possible, and even then, it's
> pretty hard to hit something the first time.

Same thing I reported yesterday -
http://marc.theaimsgroup.com/?l=linux-kernel&m=105945659716778&w=2

My system is idle and it happens after I boot and move the
mouse with gpm or XFree86.

If I only load mousedev is doesn't work. If I then load psmouse
it goes insane with any of /dev/misc/psaux, /dev/input/mouse0,
and /dev/input/mice.

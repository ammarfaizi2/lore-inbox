Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVAEPld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVAEPld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbVAEPjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:39:25 -0500
Received: from mail48-s.fg.online.no ([148.122.161.48]:24295 "EHLO
	mail48-s.fg.online.no") by vger.kernel.org with ESMTP
	id S262478AbVAEPWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:22:34 -0500
To: linux-kernel@vger.kernel.org
Subject: Logitech MX1000 Horizontal Scrolling
From: Esben Stien <b0ef@esben-stien.name>
X-Home-Page: http://www.esben-stien.name
Date: Wed, 05 Jan 2005 16:22:59 +0100
Message-ID: <873bxfoq7g.fsf@quasar.esben-stien.name>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a 12 button logitech MX1000 mouse. The buttons 11 and 12 which
are the horizontal direction of the tilt wheel gives me this the log

Jan  5 15:56:26 quasar keyboard.c: can't emulate rawmode for keycode 240

.. every time I press either button 11 or 12

I needed CONFIG_INPUT_EVDEV to read these events, btw

This gives me problems in some applications it seems, as it won't
allow me to move in one of the horizontal directions by holding the
tilt wheel for a period. It only moves me the length of a single
click. I can continue clicking myself in a direction, but when holding
down the tilt wheel, I'll only move one click in the direction.

-- 
Esben Stien is b0ef@esben-stien.name
http://www.esben-stien.name
irc://irc.esben-stien.name/%23contact
[sip|iax]:b0ef@esben-stien.name

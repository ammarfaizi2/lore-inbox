Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbVCEMw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbVCEMw3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 07:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVCEMw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 07:52:29 -0500
Received: from mail48-s.fg.online.no ([148.122.161.48]:35220 "EHLO
	mail48-s.fg.online.no") by vger.kernel.org with ESMTP
	id S262199AbVCEMwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 07:52:23 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Logitech MX1000 Horizontal Scrolling
References: <873bxfoq7g.fsf@quasar.esben-stien.name>
	<87zmylaenr.fsf@quasar.esben-stien.name>
	<20050204195410.GA5279@ucw.cz>
	<873bvyfsvs.fsf@quasar.esben-stien.name>
From: Esben Stien <b0ef@esben-stien.name>
X-Home-Page: http://www.esben-stien.name
Date: Sat, 05 Mar 2005 13:52:07 +0100
In-Reply-To: <873bvyfsvs.fsf@quasar.esben-stien.name> (Esben Stien's message
 of "Tue, 15 Feb 2005 03:40:07 +0100")
Message-ID: <87zmxil0g8.fsf@quasar.esben-stien.name>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Stien <b0ef@esben-stien.name> writes:

>> Please try if 2.6.11-rc3 is any better.

> Firefox gives me something strange, but the kernel issue is
> resolved.

Sorry, false report. 2.6.11-rc3 makes my tilt button show up as 2
buttons being pressed simultaneously, just like that previous report.

I also tried linux-2.6.11 today and it was the same. 

It shows up as both button 4 and 12 being pressed simultaneously.

ButtonPress event, serial 21, synthetic NO, window 0x1e00001,
    root 0x48, subw 0x1e00002, time 3916883, (28,38), root:(779,177),
    state 0x0, button 12, same_screen YES

EnterNotify event, serial 21, synthetic NO, window 0x1e00001,
    root 0x48, subw 0x0, time 3916883, (28,38), root:(779,177),
    mode NotifyGrab, detail NotifyInferior, same_screen YES,
    focus YES, state 0

KeymapNotify event, serial 21, synthetic NO, window 0x0,
    keys:  55  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   
           0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   

ButtonPress event, serial 21, synthetic NO, window 0x1e00001,
    root 0x48, subw 0x1e00002, time 3916907, (28,38), root:(779,177),
    state 0x0, button 4, same_screen YES

ButtonRelease event, serial 21, synthetic NO, window 0x1e00001,
    root 0x48, subw 0x1e00002, time 3916907, (28,38), root:(779,177),
    state 0x800, button 4, same_screen YES

LeaveNotify event, serial 21, synthetic NO, window 0x1e00001,
    root 0x48, subw 0x0, time 3916907, (28,38), root:(779,177),
    mode NotifyUngrab, detail NotifyInferior, same_screen YES,
    focus YES, state 0

ButtonRelease event, serial 21, synthetic NO, window 0x1e00001,
    root 0x48, subw 0x1e00002, time 3917067, (28,38), root:(779,177),
    state 0x0, button 12, same_screen YES

-- 
Esben Stien is b0ef@esben-stien.name
http://www.esben-stien.name
irc://irc.esben-stien.name/%23contact
[sip|iax]:b0ef@esben-stien.name

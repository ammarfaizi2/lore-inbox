Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315513AbSGIQDA>; Tue, 9 Jul 2002 12:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315544AbSGIQC7>; Tue, 9 Jul 2002 12:02:59 -0400
Received: from uvo1-51.univie.ac.at ([131.130.231.51]:3076 "EHLO
	gander.coarse.univie.ac.at") by vger.kernel.org with ESMTP
	id <S315513AbSGIQC6>; Tue, 9 Jul 2002 12:02:58 -0400
Message-ID: <3D2AB938.52461BDE@unet.univie.ac.at>
Date: Tue, 09 Jul 2002 10:21:44 +0000
From: Piotr Sawuk <a9702387@unet.univie.ac.at>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.21 i586)
X-Accept-Language: de-AT, de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: vojtech@suse.cz
Subject: joystick.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if I'm off-topic here, since I don't read this list.
also when replying please send me a copy...

in function js_correct(value,corr) I've found the instructions:

if (value < -32767) return -32767;
if (value > 32767) return 32767;

what's the use of these? I'm asking because my new usb-joystick
is returning those values somewhere in the middle of it's threshold
and I was wondering if disabling the above would do any good?


however, the actual reason why I've looked into that file was
because wine reported strange joystick-events 6,7,8,9 and I
just can't figure out what those are supposed to do. I've found
JS_EVENT 1 and 2 in the linux/joystick.h include, but no mention
of anything related to the number '6'. does anyone know anything
about those joystick events?

P

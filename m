Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267130AbSKXCZT>; Sat, 23 Nov 2002 21:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267137AbSKXCZT>; Sat, 23 Nov 2002 21:25:19 -0500
Received: from gettysburg.edu ([138.234.4.100]:19590 "EHLO gettysburg.edu")
	by vger.kernel.org with ESMTP id <S267130AbSKXCZR>;
	Sat, 23 Nov 2002 21:25:17 -0500
To: linux-kernel@vger.kernel.org
Message-Id: <E18FmZY-00008t-00@perseus.homeunix.net>
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Date: Sat, 23 Nov 2002 21:32:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: SIS 630 poweroff on X shutdown

While running X 4.2.99.2, under Linux 2.4.20-rc3, the control-alt-backspace key
sequence kills X; however, it also shuts down the computer.

Interestingly, although X dies as soon as the backspace is pressed, if I
release the backspace key, but hold control-alt, the computer stays on.  
Shutdown occurs as soon as control-alt is released.  If I include the X
'Option "Dont Zap"', X does not die, yet the system still shuts down.

This is not a recent development, and is not specific to my version of Linux or
X.  This occurs with all kernel configurations I've tried, including one with
AGP, DRM and framebuffer and one without AGP,DRM and framebuffer. 

I doubt this is entirely a kernel issue; I plan on contacting the X people
as well.  However, it seems that there may be a kernel problem, as X really
shouldn't take the system down.

Please CC me in all responses.

Justin Pryzby
justinpryzby@users.sf.net

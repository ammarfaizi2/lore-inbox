Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTKYTKq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 14:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbTKYTKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 14:10:46 -0500
Received: from lire.essi.fr ([157.169.1.9]:45188 "HELO lire.essi.fr")
	by vger.kernel.org with SMTP id S262882AbTKYTKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 14:10:45 -0500
Date: Tue, 25 Nov 2003 20:10:28 +0100
From: Guillaume Chazarain <guichaz@yahoo.fr>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Still some mouse problems with -test10
Message-Id: <20031125201028.33a17f83.guichaz@yahoo.fr>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My mouse is a IntelliMouse PS/2. Scrolling the wheel without pressing
the middle button works fine, but when pressing it the events are duplicated.
I am using Fedora core 1.

This is with -test10, with -test9 events were duplicated even without
pressing the middle button.

Here is an output from xev, I don't know what those KeymapNotify are,
I get one for every mouse button pressed.

KeymapNotify event, serial 23, synthetic NO, window 0x0,
    keys:  88  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   
           0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   

ButtonPress event, serial 23, synthetic NO, window 0x2600001,
    root 0x58, subw 0x0, time 309785, (85,116), root:(90,138),
    state 0x10, button 2, same_screen YES

ButtonPress event, serial 23, synthetic NO, window 0x2600001,
    root 0x58, subw 0x0, time 310464, (85,116), root:(90,138),
    state 0x210, button 5, same_screen YES

ButtonRelease event, serial 23, synthetic NO, window 0x2600001,
    root 0x58, subw 0x0, time 310464, (85,116), root:(90,138),
    state 0x1210, button 5, same_screen YES

ButtonPress event, serial 23, synthetic NO, window 0x2600001,
    root 0x58, subw 0x0, time 310464, (85,116), root:(90,138),
    state 0x210, button 5, same_screen YES

ButtonRelease event, serial 23, synthetic NO, window 0x2600001,
    root 0x58, subw 0x0, time 310464, (85,116), root:(90,138),
    state 0x1210, button 5, same_screen YES

ButtonRelease event, serial 23, synthetic NO, window 0x2600001,
    root 0x58, subw 0x0, time 311463, (85,116), root:(90,138),
    state 0x210, button 2, same_screen YES


Thanks in advance.
Guillaume.


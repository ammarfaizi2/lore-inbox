Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBNB6K>; Tue, 13 Feb 2001 20:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbRBNB6A>; Tue, 13 Feb 2001 20:58:00 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:44139 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129051AbRBNB5s>; Tue, 13 Feb 2001 20:57:48 -0500
Date: Tue, 13 Feb 2001 20:57:43 -0500 (EST)
From: Elliot Lee <sopwith@redhat.com>
X-X-Sender: <sopwith@devserv.devel.redhat.com>
Reply-To: <sopwith@redhat.com>
To: <linux-kernel@vger.kernel.org>
Subject: Driver for Casio Cassiopia Fiva touchscreen, help with conversion
 to 2.4
Message-ID: <Pine.LNX.4.32.0102132034540.20720-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://people.redhat.com/~sopwith/fidmour-linux.c is a driver
for the touch screen used on the Cassiopia Fiva MPC-501 pen computer. It
is a rather Bad Hack (seeing as it was built rather blindly to mimic the
behaviour of the Windows driver, and has IRQ/port hardcoded in), but it
works for me with the 2.2.16 kernel.

The device outputs 5 byte packets - 1 status byte, 2 bytes each for X & Y
coordinates. The devel branch of GTK+ has support for /dev/fidmour in the
Linux framebuffer backend (gtk+/gdk/linux-fb/gdkmouse-fb.c), should you
wish to see a code sample.

I'm wondering if anyone has a resource that would provide information on
porting this driver to the 2.4 kernel.

I would welcome comments on this driver, or on the MPC-501 and Linux in
general. Bonus points to anyone who actually understands why the driver
works and how the hardware works. :)

Hope this helps,
-- Elliot
Who me? I just wander from room to room.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279901AbRKDLJv>; Sun, 4 Nov 2001 06:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279902AbRKDLJk>; Sun, 4 Nov 2001 06:09:40 -0500
Received: from smtprt16.wanadoo.fr ([193.252.19.183]:34250 "EHLO
	smtprt16.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S279901AbRKDLJ1>; Sun, 4 Nov 2001 06:09:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: mrroach@uhg.net
Subject: RE: asus P5A-B psaux problem
Date: Sun, 4 Nov 2001 12:08:53 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01110412085300.00772@baldrick>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you sure the mouse is not working?  I also
have a P5A-B, PS/2 mouse and 2.4 kernel (many
versions).  I also get no dmesg about PS/2.  But
the mouse works fine!  Did you tell X windows
that you are using a PS/2 mouse?

In XF86Config (xfree86 version 4):

Section "InputDevice"
        Identifier      "Default Mouse"
        Driver          "mouse"
        Option          "CorePointer"
        Option          "Device"   "/dev/misc/psaux" # something else for you?
        Option          "Protocol"   "PS/2"
EndSection

I hope this helps,

Duncan.

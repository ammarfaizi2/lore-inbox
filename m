Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273178AbRIJDVX>; Sun, 9 Sep 2001 23:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273175AbRIJDVN>; Sun, 9 Sep 2001 23:21:13 -0400
Received: from prv-tm13.provo.novell.com ([192.108.102.143]:61578 "EHLO
	MyRealbox.com") by vger.kernel.org with ESMTP id <S273177AbRIJDVA> convert rfc822-to-8bit;
	Sun, 9 Sep 2001 23:21:00 -0400
Subject: USB Wacom PenPartner and HID + mousedev
Reply-To: spinor@myrealbox.com
From: Spin <spinor@myrealbox.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 10 Sep 2001 00:21:22 -0300
X-Mailer: NIMS ModWeb Module
MIME-Version: 1.0
Message-ID: <1000092082.54587ff9spinor@myrealbox.com>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using a USB PenPartner and having some trouble with the pointer freezing before it reaches the edge of the screen. If I use my regular mouse to continue moving the pointer, I can "teach" the stylus the boundaries of my screen, but unfortunately it soon forgets them, forcing me to start using my mouse again :)

My setup is 2.4.5 kernel + XFree 4.0.3. I'm using the HID driver since kernel documentation claims the PenPartner is a true HID device and hence should use the HID (unlike Intuos and Graphire, which need the wacom kernel module). I then use the mousedev module to create a PS/2 interface to talk to the standard mouse driver under XFree. I compiled the mousedev driver with the screen resolution option set to match the size of my 1600x1200 display.

Has anyone else had this problem too? Any suggestions for how to fix this problem or where to look in the source code for possible trouble are welcome, since I've exasperated myself at this point trying to get this tablet working well enough to do a little drawing... and the wacom mailing list for the linux driver has not been of much help since most of the people there are trying to configure the (newer) Graphire and Intuos models.

Many thanks in advance for any info (please CC: me on any replies to the mailing list).




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287720AbSAADIS>; Mon, 31 Dec 2001 22:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287723AbSAADH6>; Mon, 31 Dec 2001 22:07:58 -0500
Received: from mta06ps.bigpond.com ([144.135.25.138]:35824 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S287722AbSAADHz>; Mon, 31 Dec 2001 22:07:55 -0500
Message-Id: <200201010307.g0137icS006022@ADSL-Server.davsoft.com.au>
Content-Type: text/plain; charset=US-ASCII
From: David Findlay <david_j_findlay@yahoo.com.au>
Reply-To: david_j_findlay@yahoo.com.au
To: linux-kernel@vger.kernel.org
Subject: BUG: Joystick driver
Date: Tue, 1 Jan 2002 13:07:44 +1000
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think i've discovered a bug in the analog joystick driver. I have a 
multifunction analog joystick which defaults to a mode where the 4 standard 
joystick buttons are linked to keystrokes. In this mode the joystick has no 
standard joystick buttons, and the kernel doesn't detect it when booting. If 
i turn off this switch before booting up the kernel detects the joystick as a 
4 button 2 axis joystick correctly. Could someone please change the analog 
joystick driver so it doesn't try to detect buttons, and will just accept 
input from any button when it is pressed, even if the button wasn't 
previously detected? Or is there a better solution? Thanks,

David

P.S. Please CC me any reply to this thread.

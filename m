Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292341AbSBBSLU>; Sat, 2 Feb 2002 13:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292332AbSBBSLN>; Sat, 2 Feb 2002 13:11:13 -0500
Received: from thor.hol.gr ([194.30.192.25]:21989 "HELO thor.hol.gr")
	by vger.kernel.org with SMTP id <S292341AbSBBSK5>;
	Sat, 2 Feb 2002 13:10:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Panagiotis Moustafellos <panxer@hol.gr>
To: linux-kernel@vger.kernel.org
Subject: 2.5.2 cmpci.c Compilation error
Date: Sat, 2 Feb 2002 20:01:26 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02020220012604.00250@gryppas>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear sirs,
When i try to make bzImage the 2.5.2 kernel having enabled the following;
CONFIG_SOUND=y
CONFIG_SOUND_CMPCI=y
CONFIG_SOUND_CMPCI_FM=y
CONFIG_SOUND_CMPCI_FMIO=388
CONFIG_SOUND_CMPCI_FMIO=388
CONFIG_SOUND_CMPCI_MIDI=y
CONFIG_SOUND_CMPCI_MPUIO=330
CONFIG_SOUND_CMPCI_JOYSTICK=y
CONFIG_SOUND_CMPCI_CM8738=y
CONFIG_SOUND_CMPCI_SPDIFINVERSE=y
CONFIG_SOUND_CMPCI_SPDIFLOOP=y
CONFIG_SOUND_CMPCI_SPEAKERS=2

I get the following error;
cmpci.c: In function `cm_open_mixdev':
cmpci.c:1443: invalid operands to binary &
cmpci.c: In function `cm_release_mixdev':
cmpci.c:1457: warning: unused variable `s'
cmpci.c: In function `cm_open':
cmpci.c:2193: invalid operands to binary &
cmpci.c: In function `cm_midi_open':

and goes on for some more lines..
Is this a known bug? could it be that some options are conflicting?
Thanks in advance,

-- 
--
Panagiotis Moustafellos
(aka panXer)

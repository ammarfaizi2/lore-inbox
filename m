Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSHQLPk>; Sat, 17 Aug 2002 07:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317673AbSHQLPk>; Sat, 17 Aug 2002 07:15:40 -0400
Received: from port-212-202-184-36.reverse.qdsl-home.de ([212.202.184.36]:37393
	"EHLO intra.cycdolphin.net") by vger.kernel.org with ESMTP
	id <S317482AbSHQLPj>; Sat, 17 Aug 2002 07:15:39 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc Schoenborn <schoenborn@cycdolphin.net>
To: linux-kernel@vger.kernel.org
Subject: ps/2 probs w/ asus board
Date: Sat, 17 Aug 2002 13:19:34 +0200
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208171319.34394.schoenborn@cycdolphin.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone -

I'm having problems using the extended ps/2 procotol (here: imps/2) on an asus 
board.

_symptoms:_
* Xfree86 4.2.0:
using protocol ImPS/2 the curser jumps to the lower left corner when making 
negative movements (left/down). Button events are happening randomly.
gpm is disabled.
Protocol PS/2 works fine but wheels are not responding.

* gpm (just for testing purposes):
using protocol ImPS/2 the cursor the cursor goes crazy.
Protocol PS/2 works fine.

_possible cause:_
It seems that linux kernel is not initializing the imps/2 protocol correctly 
with that board.
Everything worked fine with a DFI K6BV3+, AMD K6-III 400.

_hardware:_
* asus a7a266-E board (ali magik-1 chipset, M1647 north, M1535D+ south)
* cpu AMD XP 2000+
* A4tech trackball; two wheels, three buttons

_notes:_
* using an XP1600+ with the same board it is possible to make use of ImPS/2 
but with limitations:
Right after starting up the X server the mouse curser jumps to the lower left 
corner when making negative movements. Switching several times from console 
to X and back _can_ solve the problem (even the mouse wheels are working, 
wow), restarting the X server multiple times _can_ solve the problem too, but 
there's no guarantee this would work.
Now, using an XP2000+ this trick doesn't work anymore.

* this problem was discussed in linux.debian.user.german, message ID 
<GfumSC.A.c5E.4V478@murphy> and following.


is there anything I can do to make this trackball work with this board?

Sincerely,
Marc


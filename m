Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131476AbRCSNsS>; Mon, 19 Mar 2001 08:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131478AbRCSNr7>; Mon, 19 Mar 2001 08:47:59 -0500
Received: from essi.essi.fr ([157.169.25.1]:60311 "EHLO essi.essi.fr")
	by vger.kernel.org with ESMTP id <S131476AbRCSNrv>;
	Mon, 19 Mar 2001 08:47:51 -0500
From: Cataldo Thomas <cataldo@essi.fr>
To: linux-kernel@vger.kernel.org
Subject: Problem with aha152x driver and recent 2.4
Date: Mon, 19 Mar 2001 14:30:30 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <01031914472403.05805@nessie>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since 2.4.1ac13 (linux 2.4.1 was ok for me) , i'm experiencing random problems
(read crashes) when using my yamaha cd drive. 
With 2.4.1ac13, the problem was (i think) with the detection code :
when i used append="aha152x=0x140,9,7,1,1", the kernel oopses on detection
of the board. If I remove the parameter line, everything goes fine :-) but my
board is not detected :-(.
In 2.4.2 (vanilla), everything is "fine" but I'm getting some random crashes
when i use the cd drive.
Nothing in the logs and no magic sys keys working.

The card had always worked fine (2.2 series, 2.4.0, 2.4.1). The driver is
compiled in kernel.

I know that the driver was upgraded in 2.4.1ac13, but i don't know what was
merged in 2.4.2... so if you've got an idea...

-- 

Passe que moi, au départ, j'avais fait informatique comme études, pas
NT, et je voudrais revenir à mon métier premier.
-+- BB in Guide du Linuxien pervers - Bien configurer son metier.



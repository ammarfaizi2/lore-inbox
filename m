Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312443AbSCZTEX>; Tue, 26 Mar 2002 14:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312587AbSCZTEN>; Tue, 26 Mar 2002 14:04:13 -0500
Received: from correo.e-technik.uni-ulm.de ([134.60.21.81]:55301 "EHLO
	correo.e-technik.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S312443AbSCZTEF>; Tue, 26 Mar 2002 14:04:05 -0500
Message-Id: <200203261904.UAA08226@correo.e-technik.uni-ulm.de>
Content-Type: text/plain; charset=US-ASCII
From: Kai-Boris Schad <kschad@correo.e-technik.uni-ulm.de>
Reply-To: kschad@correo.e-technik.uni-ulm.de
Organization: =?iso8859-15?q?Universit=E4t?= Ulm
To: linux-kernel@vger.kernel.org
Subject: Update: Kernel 2.4.17/19-pre4  with VT8367 [KT266] crashes on heavy ide load togeter with heavy network load
Date: Tue, 26 Mar 2002 20:04:01 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

First thanks a lot for the good ideas and comments on my previous posting. I 
updated the kernel to 2.4.19-pre4 and it seem's to improve the situation. 
There  was no crash with the RTL Network Card but the system response boged 
down sometimes for a few (up to 10) seconds. Then I tried the same togeter 
with the "3com 3c905C" networkcard and the system hung a few seconds after 
starting the copy-commands "dd count=16M if=/dev/zero of=/home/test0&" and
 "cp /home/zero /dev/null&" and "ico" on an remote terminal for network load. 
Thus my personal work arround would be to use the rtl network card - but 
there remains this problem.

Kai

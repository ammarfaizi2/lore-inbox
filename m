Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311912AbSCOCil>; Thu, 14 Mar 2002 21:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311913AbSCOCic>; Thu, 14 Mar 2002 21:38:32 -0500
Received: from host194.steeleye.com ([216.33.1.194]:40976 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S311912AbSCOCiZ>; Thu, 14 Mar 2002 21:38:25 -0500
Message-Id: <200203150238.g2F2cGe21131@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: lm@bitmover.com
cc: linux-kernel@vger.kernel.org
Subject: Problems using new Linux-2.4 bitkeeper repository.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Mar 2002 21:38:16 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do those of us who've been using the

http://gkernel.bitkeeper.net/marcelo-2.4

for development resync against the kernel24.bkbits.net tree?  It looks like 
the changes from 2.4.18-pre8 onwards all have different patch IDs in the new 
tree; so when I try to do a pull from my current repository I get tons of 
conflicts, if I try to do a receive of just the patch set I get a resync error:

takepatch: can't find parent ID
        jgarzik@mandrakesoft.com|ChangeSet|20020225230300|18879
        in RESYNC/SCCS/s.ChangeSet

The thought of taking everything back to the common ancestor and then trying 
to apply the changes one at a time and adding the change logs by hand isn't 
that appealing (I have 3 2.4 repositories, some with upwards of 10 additional 
change sets in them).

James



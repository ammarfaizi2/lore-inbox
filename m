Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbTEMERl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 00:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTEMERl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 00:17:41 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:38016 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S262728AbTEMERk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 00:17:40 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16064.29935.317843.843731@wombat.chubb.wattle.id.au>
Date: Tue, 13 May 2003 14:30:39 +1000
To: linux-kernel@vger.kernel.org
Subject: Adaptec 29160 SCSI doesn't work for me in 2.5.69
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	My root disc is a Quantum Atlas 10k driver attached to an
Adaptec 29160N SCSI controller.  I haven't been able to boot a 2.5
kernel on this machine since around 2.5.48.

The errors vary; as of this morning (2003.05.13) (2.5.69 BK) I see:

Data overrun detected in Data-in phase, Tag=0x2
Have seen Data Phase,  Length = 36, NumSGs = 1.

repeated a whole swag of times, then the kernel gives up on trying to
mount the root partition.


I'm rebuilding now with the old Adaptec driver, and will send another
email as to whether it works.

Peter c

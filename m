Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262021AbSJDPPr>; Fri, 4 Oct 2002 11:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbSJDPOd>; Fri, 4 Oct 2002 11:14:33 -0400
Received: from math.ut.ee ([193.40.5.125]:4262 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id <S262006AbSJDPOT>;
	Fri, 4 Oct 2002 11:14:19 -0400
Date: Fri, 4 Oct 2002 18:19:45 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre9: floating point in tda7432 module
Message-ID: <Pine.GSO.4.44.0210041817000.12474-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the unresolved module symbols are now fixed on PPC but one
brokenmodule remains (with my config):

depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre9/kernel/drivers/media/video/tda7432.o
depmod:         __fixdfsi
depmod:         __floatsidf
depmod:         __divdf3
depmod:         __muldf3
depmod:         __subdf3

Looks like the tda7432 module tries to use some floating point in the
kernel... bad.

-- 
Meelis Roos (mroos@linux.ee)


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262353AbSI2AOL>; Sat, 28 Sep 2002 20:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262355AbSI2AOL>; Sat, 28 Sep 2002 20:14:11 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:54673 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262353AbSI2AOL>; Sat, 28 Sep 2002 20:14:11 -0400
X-Face: >Q)4Pn.JVfRz{G(G_eIkykbZGG\)2mk8:5a"{^Mk07iC#F.t2L7h<Sa|7Zr1_L8[nbiq:8F
 %o\(7>|]{*cFg$GEPDdun~+UTjG(^4z<_Ksw%L-\w0xDmUR~<zsnGH]&sK=M\Y=;U4XZ"z)[CX6I6d
 _p
To: linux-kernel@vger.kernel.org
Cc: viro@psu.edu
Subject: OSF partition naming
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 29 Sep 2002 02:19:44 +0200
Message-ID: <871y7dabq7.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (broccoli)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a patch by Alexander Viro:

http://linux.bkbits.net:8080/linux-2.5/diffs/fs/partitions/osf.c@1.4

changed the naming scheme of OSF partitions: empty partitions are now
skipped, whereas previously the partition number would always
correspond directly to the number in the partition table. E. g, if you
have partition a and d, you end up with hda1 and hda2 instead of hda1
and hda4.

I wonder whether that is intended? Is there any problem with
non-continguous partition numbers in 2.5?

-- 
	Falk

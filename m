Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318884AbSG1ByA>; Sat, 27 Jul 2002 21:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318885AbSG1Bx7>; Sat, 27 Jul 2002 21:53:59 -0400
Received: from salmon.maths.tcd.ie ([134.226.81.11]:45821 "HELO
	salmon.maths.tcd.ie") by vger.kernel.org with SMTP
	id <S318884AbSG1Bx5>; Sat, 27 Jul 2002 21:53:57 -0400
Date: Sun, 28 Jul 2002 02:57:01 +0100
From: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
To: linux-kernel@vger.kernel.org
Subject: kernel-2.5.29
Message-ID: <20020728025701.A3490@birdsnest.maths.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/partitions/Config.in l.28
Should dep_bool have a third argument?
As it stands, "make xconfig" fails at this point.
It works if I add $CONFIG_EXPERIMENTAL as a third argument.

==========================================
Script started on Sun Jul 28 00:34:47 2002
tim@william linux]$ make xconfig
make[1]: Entering directory `/usr/src/linux-2.5.29/scripts'
  Generating kconfig.tk
fs/partitions/Config.in: 28: can't handle dep_bool/dep_mbool/dep_tristate condition
chmod 755 kconfig.tk
make[1]: Leaving directory `/usr/src/linux-2.5.29/scripts'
...
Script done on Sun Jul 28 00:34:57 2002
==========================================

-- 
Timothy Murphy  
e-mail: tim@birdsnest.maths.tcd.ie
tel: 086-233 6090
s-mail: School of Mathematics, Trinity College, Dublin 2, Ireland

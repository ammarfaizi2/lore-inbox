Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269974AbRHXHSd>; Fri, 24 Aug 2001 03:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270178AbRHXHSY>; Fri, 24 Aug 2001 03:18:24 -0400
Received: from erm1.u-strasbg.fr ([130.79.74.61]:4 "HELO erm1.u-strasbg.fr")
	by vger.kernel.org with SMTP id <S269974AbRHXHSO>;
	Fri, 24 Aug 2001 03:18:14 -0400
Date: Fri, 24 Aug 2001 09:29:37 +0200
To: linux-kernel@vger.kernel.org
Subject: lance-modul:ping produces neighbour table overflow
Message-ID: <20010824092937.C30405@erm1.u-strasbg.fr>
Mail-Followup-To: bboett@erm1.u-strasbg.fr,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: bboett@erm1.u-strasbg.fr (Bruno Boettcher)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
i have as a second network card a PCnet card which shows up nicely with
a lspci, where i can load the module without prob, can configure it with
ifconfig but when i try to ping it itself i get:
ping 192.168.0.254
PING 192.168.0.254 (192.168.0.254): 56 data bytes
neighbour table overflow
ping: sendto: No buffer space available
ping: wrote 192.168.0.254 64 chars, ret=-1

there's plenty of free memory, so i can't see whats wrong....
kernel is debianized 2.4.9 kernel on an Athlon

-- 
ciao bboett
==============================================================
bboett@earthling.net
http://inforezo.u-strasbg.fr/~bboett http://erm1.u-strasbg.fr/~bboett
===============================================================
the total amount of intelligence on earth is constant.
human population is growing....

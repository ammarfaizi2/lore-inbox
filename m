Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbTFJV6Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTFJV5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:57:21 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:49077 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262151AbTFJVzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 17:55:20 -0400
Date: Tue, 10 Jun 2003 19:06:15 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.21-rc8
Message-ID: <Pine.LNX.4.55L.0306101845460.30401@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes -rc8. If nothing really bad happens in 2 days, this becomes
final.


Summary of changes from v2.4.21-rc7 to v2.4.21-rc8
============================================

Geert Uytterhoeven <geert@linux-m68k.org>:
  o Fix ext2fs warning

Hugh Dickins <hugh@veritas.com>:
  o Fix shmctl(SHM_LOCK/UNLOCK) deadlock

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Backout erroneous kiobuf dcache flush changes Cset exclude: jsun@mvista.com|ChangeSet|20030425203656|60956
  o Changed EXTRAVERSION to -pre8
  o Cset exclude: geert@linux-m68k.org|ChangeSet|20030609201637|12385
  o Cset exclude: geert@linux-m68k.org|ChangeSet|20030609201907|11405
  o Remove bogus license for Rocket driver and change it to GPL


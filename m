Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbTEZUo0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 16:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbTEZUo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 16:44:26 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:16768 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262235AbTEZUoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 16:44:23 -0400
Date: Mon, 26 May 2003 17:35:34 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.21-rc4
Message-ID: <Pine.LNX.4.55L.0305261734320.21581@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes -rc4, hopefully fixing all problems now.

rc5 will only be released in case of REALLY bad problems.

Please test it extensively.


Summary of changes from v2.4.21-rc3 to v2.4.21-rc4
============================================

<minyard@acm.org>:
  o IPMI fixes

<viro@parcelfarce.linux.theplanet.co.uk>:
  o Fix writing to /dev/console

Barry K. Nathan <barryn@pobox.com>:
  o Correctly fix the ioperm issue

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o Update ide/ppc/pmac.c
  o Fix controlfb build with gcc3.3
  o PPC32 Fix warning with ndelay (with patch !)

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -rc4
  o Cset exclude: c-d.hailfinger.kernel.2003@gmx.net|ChangeSet|20030526190224|33683
  o Really fix xconfig breakage


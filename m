Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbTL0BQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 20:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265296AbTL0BQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 20:16:29 -0500
Received: from c3eea79a9.cable.wanadoo.nl ([62.234.121.169]:47620 "EHLO
	gonzo.bedstee.intern") by vger.kernel.org with ESMTP
	id S265291AbTL0BQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 20:16:27 -0500
From: Adriaan Penning <a.penning@luon.net>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at buffer.c:2570!
Date: Sat, 27 Dec 2003 02:27:30 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Cc: benh@kernel.crashing.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312270227.30791.a.penning@luon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running Linux 2.4.23-ben1 of 3 days ago (rsync'd) on an iBook G4 800.
As I tried to mount a CD created in OS X with

mount -t hfs /dev/scd0 /cdrom

I got this message:

kernel BUG at buffer.c:2570!
verctor: 0 at pc = c00452e8, lr = c00452e8
msr = 9032, sp = cb5e5cc0 [cb5e5bf8]
current = cb5e4000, pid = 876, comm = mount
mon>

This bug is reproducable too (tried it).

I don't have access to an installed Intel machine right now, so I don't know 
if it's PPC specific.


regards,
Adriaan






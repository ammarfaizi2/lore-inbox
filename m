Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130215AbRBZPNk>; Mon, 26 Feb 2001 10:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130199AbRBZPNL>; Mon, 26 Feb 2001 10:13:11 -0500
Received: from adsl-64-163-64-75.dsl.snfc21.pacbell.net ([64.163.64.75]:18948
	"EHLO konerding.com") by vger.kernel.org with ESMTP
	id <S130237AbRBZPLC>; Mon, 26 Feb 2001 10:11:02 -0500
Message-Id: <200102261511.f1QFB0h32378@konerding.com>
To: linux-kernel@vger.kernel.org
Subject: IDE-TAPE (Onstream DI-30) problems 2.4.*
Date: Mon, 26 Feb 2001 07:11:00 -0800
From: dek_ml@konerding.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks:

Since upgrading to 2.4.* from 2.2.18 (with ide-patches to support
my Onstream DI30)  I've seen some wierd behavior.  When I back up my
filesystem to tape using tar, it seems to interfere with the network,
or something.  In particular, I run vncserver on the host and connect via
vncviewer from another host.  Shortly after I start the tape backup, the
vncviewer closes.  I can reconnect to it but shortly after, it will close
again.  The vncserver process continues to run.  I can always reconnect
to it but the connection will be terminated after a short period of time.
When the tape backup stops, vnc returns to normal.  I haven't observed
the problem with any applications than vnc (yet).   There are no messages
in the syslog to indicate anything abnormal is occurring.

Here's what I see at boot-up:

Feb 25 22:39:08 camera1 kernel: ide-tape: hdc <-> ht0: OnStream DI-30 rev 1.06
Feb 25 22:39:08 camera1 kernel: ide-tape: hdc <-> ht0: 990KBps, 64*32kB buffer, 10208kB pipeline, 60ms tDSC, DMA


-----------------------------------------------------------------------------
David Konerding   
Email: dek_ml@konerding.com
WWW: http://picasso.nmr.ucsf.edu/~dek
PGP: http://picasso.nmr.ucsf.edu/~dek/content_pgp.html
-----------------------------------------------------------------------------

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbSLaTDh>; Tue, 31 Dec 2002 14:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbSLaTDh>; Tue, 31 Dec 2002 14:03:37 -0500
Received: from hera.cwi.nl ([192.16.191.8]:51374 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264844AbSLaTDe>;
	Tue, 31 Dec 2002 14:03:34 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 31 Dec 2002 20:11:59 +0100 (MET)
Message-Id: <UTC200212311911.gBVJBxe03777.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.50 responsiveness
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fetched Solaris 9 CDROM images yesterday, unpacked, copied, etc.
Manipulating these 600+ MB files totally kills the machine
(with 256 MB memory). Keystrokes are reacted to after half a minute.
It is impossible to use the mouse since the kernel is too slow
to accept mouse packets within its self-imposed timeout, so that
the logs are full of
psmouse.c: Lost synchronization, throwing 1 bytes away.
psmouse.c: Lost synchronization, throwing 3 bytes away.
psmouse.c: Lost synchronization, throwing 1 bytes away.
psmouse.c: Lost synchronization, throwing 3 bytes away.
The clock lost somewhat over 10 minutes.

This is really primitive behaviour.

Andries


[everything vanilla - no settings changed, no hdparm used]

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTLXAiU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 19:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTLXAiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 19:38:20 -0500
Received: from dsl-fip-40.world-net.co.nz ([210.55.219.40]:18639 "EHLO
	med.co.nz") by vger.kernel.org with ESMTP id S262762AbTLXAiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 19:38:19 -0500
Message-ID: <37133.219.88.110.193.1072226080.squirrel@mail.med.co.nz>
Date: Wed, 24 Dec 2003 13:34:40 +1300 (NZDT)
Subject: linux-2.6.0 kernel distribution non-world-readable files
From: "Ross Boswell" <drb@med.co.nz>
To: <linux-kernel@vger.kernel.org>
Reply-To: drb@med.co.nz
X-Mailer: SquirrelMail (version 1.2.9)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In trying to do the Right Thing (tm) and compile the kernel without
root privilege, I discovered that the following files in the
standard linux-2.6.0 distribution seem to have read permission
for user and group but not other:

linux-2.6.0/Documentation/scsi/ChangeLog.megaraid
linux-2.6.0/drivers/input/joystick/grip_mp.c
linux-2.6.0/drivers/char/agp/isoch.c
linux-2.6.0/include/video/neomagic.h

I guess this needs fixing.

Merry Christmas -- Ross



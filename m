Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265421AbTGHWkj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265416AbTGHWkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:40:39 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:49062
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S267880AbTGHWke
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:40:34 -0400
Date: Tue, 8 Jul 2003 19:05:17 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Ryan Underwood <nemesis-lists@icequake.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Forking shell bombs
Message-ID: <20030708190517.A24202@animx.eu.org>
References: <20030708193401.24226.95499.Mailman@lists.us.dell.com> <20030708202819.GM1030@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20030708202819.GM1030@dbz.icequake.net>; from Ryan Underwood on Tue, Jul 08, 2003 at 03:28:19PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nope, on my system running stock 2.4.21, after hitting enter, wait about 2
> seconds, and the system is frozen.  Telnet connects but never gets a
> shell.  None of the SysRq process-killing combos have any effect.  After
> a few failed killalls (which eventually killed the one shell I was able
> to get), and Alt-SysRq-S never completing the sync, I gave up and
> Alt-SysRq-B.

I've used killall -STOP several times since it will fill up the process
table.  once they're all in T state, I killall -KILL them.  seems to work
for me.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals

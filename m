Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264407AbTFUNte (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 09:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTFUNqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 09:46:52 -0400
Received: from mail-5.tiscali.it ([195.130.225.151]:25524 "EHLO
	mail-5.tiscali.it") by vger.kernel.org with ESMTP id S263631AbTFUNi3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 09:38:29 -0400
Date: Sat, 21 Jun 2003 15:52:35 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Subject: [2.5.72] spin_is_locked on uninitialized spinlock
Message-ID: <20030621135235.GA6953@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At shutdown:

kernel/fork.c:140 spin_is_locked on uninitialized spinlock ee24fcfc.
kernel/fork.c:142 spin_is_locked on uninitialized spinlock ee24fcfc.
kernel/fork.c:140 spin_is_locked on uninitialized spinlock ee24fcfc.
kernel/fork.c:142 spin_is_locked on uninitialized spinlock ee24fcfc.
kernel/fork.c:140 spin_is_locked on uninitialized spinlock ee24fcfc.
kernel/fork.c:142 spin_is_locked on uninitialized spinlock ee24fcfc.

I'm unable to reproduce it. Kernel is UP, with preempt.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Se alla sera, dopo una strepitosa vittoria, guardandoti allo
specchio dovessi notare un secondo paio di palle, che il tuo 
cuore non si riempia d'orgoglio, perche` vuol dire che ti 
stanno inculando -- Saggio Cinese

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318145AbSIJV3Q>; Tue, 10 Sep 2002 17:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318151AbSIJV3Q>; Tue, 10 Sep 2002 17:29:16 -0400
Received: from node-c-067b.a2000.nl ([62.194.6.123]:2413 "HELO
	pipc.pipsels.pip") by vger.kernel.org with SMTP id <S318145AbSIJV3N>;
	Tue, 10 Sep 2002 17:29:13 -0400
Date: Tue, 10 Sep 2002 23:33:49 +0200
From: Remco Post <r.post@sara.nl>
To: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: [TRIVIAL PATCH] typo in svclock.c (linuxppc-2.5 tree)
Message-Id: <20020910233349.613c01ae.r.post@sara.nl>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

did a rr in vi and then some diff -c:

*** linuxppc-2.5/fs/lockd/svclock.c.org	Tue Sep 10 23:13:29 2002
--- linuxppc-2.5/fs/lockd/svclock.c	Tue Sep 10 23:16:37 2002
***************
*** 467,473 ****
   * the block to the head of nlm_blocked where it can be picked up by lockd.
   */
  static void
! nlmsvc_notify_blocked(stsuct file_lock *fl)
  {
  	struct nlm_block	**bp, *block;
  
--- 467,473 ----
   * the block to the head of nlm_blocked where it can be picked up by lockd.
   */
  static void
! nlmsvc_notify_blocked(struct file_lock *fl)
  {
  	struct nlm_block	**bp, *block;
  

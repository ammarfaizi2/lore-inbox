Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbUCPCw3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 21:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbUCPCwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 21:52:19 -0500
Received: from [12.46.110.22] ([12.46.110.22]:50569 "EHLO saratoga.bjrosen.com")
	by vger.kernel.org with ESMTP id S262868AbUCPCo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 21:44:26 -0500
Subject: 2.6.4 install bug
From: "B. Joshua Rosen" <bjrosen@polybus.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1079405134.4117.12.camel@saratoga.bjrosen.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Mon, 15 Mar 2004 21:45:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 make modules_install
  INSTALL fs/adfs/adfs.ko
  INSTALL fs/affs/affs.ko
  INSTALL fs/autofs4/autofs4.ko
  INSTALL fs/befs/befs.ko
  INSTALL fs/bfs/bfs.ko
  INSTALL arch/i386/kernel/cpuid.ko
  INSTALL fs/afs/kafs.ko
  INSTALL arch/i386/kernel/microcode.ko
  INSTALL arch/i386/kernel/msr.ko
  INSTALL arch/i386/kernel/scx200.ko
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.4; fi
WARNING: /lib/modules/2.6.4/kernel/fs/afs/kafs.ko needs unknown symbol
rxrpc_call_read_data
WARNING: /lib/modules/2.6.4/kernel/fs/afs/kafs.ko needs unknown symbol
rxrpc_create_transport
WARNING: /lib/modules/2.6.4/kernel/fs/afs/kafs.ko needs unknown symbol
rxrpc_put_call
WARNING: /lib/modules/2.6.4/kernel/fs/afs/kafs.ko needs unknown symbol
rxrpc_add_service
WARNING: /lib/modules/2.6.4/kernel/fs/afs/kafs.ko needs unknown symbol
rxrpc_put_connection
WARNING: /lib/modules/2.6.4/kernel/fs/afs/kafs.ko needs unknown symbol
rxrpc_call_write_data
WARNING: /lib/modules/2.6.4/kernel/fs/afs/kafs.ko needs unknown symbol
rxrpc_put_transport
WARNING: /lib/modules/2.6.4/kernel/fs/afs/kafs.ko needs unknown symbol
rxrpc_call_abort
WARNING: /lib/modules/2.6.4/kernel/fs/afs/kafs.ko needs unknown symbol
rxrpc_del_service
WARNING: /lib/modules/2.6.4/kernel/fs/afs/kafs.ko needs unknown symbol
rxrpc_create_connection
WARNING: /lib/modules/2.6.4/kernel/fs/afs/kafs.ko needs unknown symbol
rxrpc_create_call
-- 
B. Joshua Rosen <bjrosen@polybus.com>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262061AbSIPOoE>; Mon, 16 Sep 2002 10:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262066AbSIPOoE>; Mon, 16 Sep 2002 10:44:04 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:60848 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S262061AbSIPOoD>; Mon, 16 Sep 2002 10:44:03 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.5.35: fs.o
Date: Mon, 16 Sep 2002 16:51:23 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209161651.23546@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happens:

fs/fs.o: In function `flush_old_exec':
fs/fs.o(.text+0x9b1c): undefined reference to `wait_task_inactive'

.config will be send if requested.

Eike

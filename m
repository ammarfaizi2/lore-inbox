Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbUCEAhF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 19:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbUCEAhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 19:37:05 -0500
Received: from smtp09.auna.com ([62.81.186.19]:13790 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S262083AbUCEAgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 19:36:50 -0500
Date: Fri, 5 Mar 2004 01:36:49 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: no locks available ???
Message-ID: <20040305003649.GA6726@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I am trying to lock a file from about 40 boxes, mark a line and unlock it
(kinda job dispatcher ;) ). Via NFS.

Just 8 boxes can get the lock. After that
(even when the 8 boxes got their jobs and are working, so unlocked the file),
the rest of boxes fail on fcntl() with 'no locks available'. 

Server and clients are RH9.0, with kernel  2.4.20 (various RH versions).

Any idea ? Kernel problem ? NFS problem ? Tunable ?

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Community) for i586
Linux 2.6.4-rc1-jam2 (gcc 3.4.0 (Mandrake Linux 10.0 3.4.0-0.4mdk))

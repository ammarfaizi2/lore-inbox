Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbTGKRpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264593AbTGKRpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:45:09 -0400
Received: from aneto.able.es ([212.97.163.22]:2535 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264592AbTGKRpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:45:06 -0400
Date: Fri, 11 Jul 2003 19:59:47 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: gcc-3.3.1 breaks kernel
Message-ID: <20030711175947.GC2791@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Any brave soul there is using a prerelease of gcc-3.3.1 to build kernels ?
(don't know if RawHide or SuSE beta or any other have that, apart from
MandrakeCooker).

I have tried both with 22-pre2 and 22-pre4 and both hang. They
can not start /sbin/init (or at least hang there). Once I got to
a bash prompt with init=/bin/bash, and ls listed everything _twice_ and
then hung.

Any idead about what pice of code is being miscompiled ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre2-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))

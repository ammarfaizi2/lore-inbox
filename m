Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVBWPZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVBWPZX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 10:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVBWPZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 10:25:23 -0500
Received: from alog0402.analogic.com ([208.224.222.178]:1152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261187AbVBWPZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 10:25:19 -0500
Date: Wed, 23 Feb 2005 10:24:28 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: accept() fails with EINTER
Message-ID: <Pine.LNX.4.61.0502231009380.5342@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trying to run an old server with a new kernel. A connection
fails with "interrupted system call" as soon as a client
attempts to connect. A trap in the code to continue
works, but subsequent send() and recv() calls fail in
the same way.

Anybody know how to mask that SIGIO (or whatever signal)?
Setting signal(SIGIO, SIG_IGN) doesn't do anything useful.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

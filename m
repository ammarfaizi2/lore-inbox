Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUJVTby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUJVTby (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUJVTHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:07:53 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267165AbUJVTHC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:07:02 -0400
Date: Fri, 22 Oct 2004 15:07:02 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: printk() with a spin-lock held.
Message-ID: <Pine.LNX.4.61.0410221504500.6075@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux-2.6.9 will bug-check and halt if my code executes
a printk() with a spin-lock held.

Is this the intended behavior? If so, NotGood(tm).

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.

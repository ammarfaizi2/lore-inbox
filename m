Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269484AbUJLGPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269484AbUJLGPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269477AbUJLGP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:15:29 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:32013 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269473AbUJLGPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:15:16 -0400
Message-ID: <46561a79041011231549ea310a@mail.gmail.com>
Date: Tue, 12 Oct 2004 11:45:16 +0530
From: suthambhara nagaraj <suthambhara@gmail.com>
Reply-To: suthambhara nagaraj <suthambhara@gmail.com>
To: main kernel <linux-kernel@vger.kernel.org>
Subject: kernel stack
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have not understood how the common kernel stack in the
init_thread_union(2.6 ,init_task_union in case of 2.4) works for all
the processes which run on the same processor. The scheduling is round
robin and yet the things on the stack (saved during SAVE_ALL) have to
be maintained after a switch without them getting erased. I am
familiar with only the i386 arch implementation.

Please help

regards,
Suthambhara

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbULQA4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbULQA4J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 19:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbULQAzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 19:55:23 -0500
Received: from bay23-f33.bay23.hotmail.com ([64.4.22.83]:5448 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262431AbULQAuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:50:07 -0500
Message-ID: <BAY23-F33C6A7E30074C6BD402CBACAAF0@phx.gbl>
X-Originating-IP: [80.15.132.11]
X-Originating-Email: [mariabelliti@hotmail.com]
From: "maria belliti" <mariabelliti@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: user/kernel level thread and thread's models mapping
Date: Fri, 17 Dec 2004 00:49:41 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 17 Dec 2004 00:50:05.0663 (UTC) FILETIME=[597406F0:01C4E3D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I wish to be personally CC'ed the answers/comments posted to the list in 
response to this post

Theoritically, user level thread ensures thread management , such as
scheduling and context switch, to be performed without a system call
i.e Kernel intervention whereas with kernel level threads, kernel is
aware about the threads and the context switch is done by the kernel
which requires then a system call and mode switch. Meanwhile there are
three models to map user threads to kernel threads: one to one, many
to many, many to one.

My question is how can we have a conjunction of user level thread and
many to many model (or one to one model)? One to one model maps each
user thread to kernel thread which are normally used to perform
context switch at the kernel level (mode). However user level thread
dictates that context switch should be done without kernel
intervention!!

I read that Java switched from green to native mode, which involves
one to one model mapping and yet it is said that context switch is
done at the user level with no intervention from the kernel... that's
my confusion

thanks

_________________________________________________________________
Use MSN Messenger to send music and pics to your friends 
http://www.msn.co.uk/messenger


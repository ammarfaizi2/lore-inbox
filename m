Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWCXVQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWCXVQv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 16:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWCXVQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 16:16:51 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:28435 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751388AbWCXVQu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 16:16:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LHhW++KMkkADIOihiXfTwcsZR/gp8s0oYn/FkAwIwbE3trfIeLvjGNMnF2icwNUMbC/7oTtlltYG57ki7W8CmzEXXm3lXlxPL4EYxu7z3X7rXwvJxKvlzNCZ6arLsO3uuue+gE11VSNvQuHiu3yecgdx8kFGro0NR2rpk+kUABs=
Message-ID: <47fee7c0603241316u2277a726g80604364bc2781c8@mail.gmail.com>
Date: Fri, 24 Mar 2006 14:16:49 -0700
From: "Amit Singh" <amitx.palsingh@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Add a field to task_struct
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need to add a field to task_struct and assign its value when i
create a new task using the sys_clone system call. I have changed the
do_fork method for that but i want to know how can i provide value for
the new field that i added, my idea is that i need to change the
system call to support more parameters.

It is currently using _syscall2 or _syscall5. I want it to be able to
support _syscall3 with two arguements being flags and child stack and
third arguement being the value for the field i added to task_struct.

Can someone help me with that.

-Amit

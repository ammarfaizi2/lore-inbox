Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbUJYKgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbUJYKgL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 06:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbUJYKgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 06:36:11 -0400
Received: from cantva.canterbury.ac.nz ([132.181.2.27]:31242 "EHLO
	cantva.canterbury.ac.nz") by vger.kernel.org with ESMTP
	id S261750AbUJYKb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 06:31:58 -0400
Date: Mon, 25 Oct 2004 23:31:55 +1300
From: ych43 <ych43@student.canterbury.ac.nz>
Subject: process with socket
To: linux-kernel@vger.kernel.org
Message-id: <417B54C1@webmail>
MIME-version: 1.0
X-Mailer: WebMail (Hydra) SMTP v3.61
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-WebMail-UserID: ych43
X-EXP32-SerialNo: 00002797
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I am working on UNIX Network Programming (sockets programming in C). My 
problem is I do not know how to identify whether a process in Linux kernel has 
a socket. Because so many different processes in Linux kernel are running, a 
process forks many child processes and forms a process tree. I want to 
identify a process that has socket and saves state data about it. Then saves 
the same data about his parent process and walks up the process tree by 
repeating this procedure until a process with PID 0 is reached. But I do not 
know how to identify if a process has a socket.


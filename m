Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTKHVft (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 16:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTKHVfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 16:35:48 -0500
Received: from nmail1.systems.pipex.net ([62.241.160.130]:61062 "EHLO
	nmail1.systems.pipex.net") by vger.kernel.org with ESMTP
	id S262129AbTKHVfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 16:35:48 -0500
Message-ID: <1068327129.3fad60d9adee1@netmail.pipex.net>
Date: Sat,  8 Nov 2003 21:32:09 +0000
From: "\\\"shaheed r. haque\\\"" <srhaque@iee.org>
To: maze@cela.pl, linux-kernel@vger.kernel.org
Subject: Re:Question: Returning values from kernel FIFO to userspace
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: PIPEX NetMail (IMP3.1)
X-Originating-IP: 134.242.21.142
X-PIPEX-Username: aozw65%dsl.pipex.com
X-Usage: PIPEX NetMail is subject to the standard PIPEX terms and conditions of use
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not sure if this is compatible with the zen of /proc, but one technique for 
handling such "destructive reads" from a FIFO, is to only pop the FIFO with an 
explicit operation, such as a write.

Perhaps this can work for you?

Thanks, Shaheed



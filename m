Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbTJNOux (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 10:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTJNOux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 10:50:53 -0400
Received: from alpha.cpe.ku.ac.th ([158.108.32.31]:47068 "EHLO
	alpha.cpe.ku.ac.th") by vger.kernel.org with ESMTP id S262648AbTJNOuw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 10:50:52 -0400
Date: Tue, 14 Oct 2003 21:50:46 +0700 (ICT)
From: Theewara Vorakosit <g4685034@alpha.cpe.ku.ac.th>
To: <linux-kernel@vger.kernel.org>
cc: <g4685034@cc.cpe.ku.ac.th>
Subject: get memory usage
Message-ID: <Pine.LNX.4.33.0310142146430.21938-100000@alpha.cpe.ku.ac.th>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,
	I want to get memory usage of myself and my child process. I try
to use getrusage but the memory field in rusage struct is always 0. I
check getrusage function in kernel/sys.c. I found that there is no memory
usage information so the memory usage by getrusage is always 0. Do I
understand correct? And is there any other function to do this?
Thanks,
Theewara


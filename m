Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263156AbTCYSQ2>; Tue, 25 Mar 2003 13:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263195AbTCYSQ2>; Tue, 25 Mar 2003 13:16:28 -0500
Received: from pollux.cse.Buffalo.EDU ([128.205.35.2]:24522 "EHLO
	pollux.cse.buffalo.edu") by vger.kernel.org with ESMTP
	id <S263156AbTCYSQ2>; Tue, 25 Mar 2003 13:16:28 -0500
Date: Tue, 25 Mar 2003 13:27:38 -0500 (EST)
From: Ramkumar Chinchani <rc27@cse.Buffalo.EDU>
To: <linux-kernel@vger.kernel.org>
Subject: System call interception in kernel 2.5 +
Message-ID: <Pine.SOL.4.30.0303251322210.27394-100000@pollux.cse.buffalo.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had written a software that intercepted system calls in an ad-hoc
manner from a linux kernel module on 2.4 kernel (thanks to the exported
symbol sys_call_table). Agreed that race conditions could easily arise.

1) Considering that it is no longer exported, how can
one intercept system calls?

2) Is there a API to do that in the new kernel?

3) I recently read an article which said that one could register new
system calls dynamically. Does this feature actually exist? If so, is
there any way one can intercept system calls using this feature?

Thanks.

-Ram


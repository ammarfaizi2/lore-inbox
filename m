Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270857AbRHXDxu>; Thu, 23 Aug 2001 23:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270862AbRHXDxk>; Thu, 23 Aug 2001 23:53:40 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:27916 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S270857AbRHXDxa>; Thu, 23 Aug 2001 23:53:30 -0400
Message-ID: <3B864198.9E132BFB@ntsp.nec.co.jp>
Date: Fri, 24 Aug 2001 11:59:21 +0000
From: Pete Marvin King <pmking@ntsp.nec.co.jp>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: socket problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    Is it possible to increase the maximum sockets that can be opened
simultaneously?
I'd like it to reach 1024, is it possible?

    I'm currently doing a stress test on postgres. we created a dummy
client that would
connect to it 1024 times. But is just stops at 324,
postgres reports : " postmaster: StreamConnection: accept: Too many open
files in system".

    I don't think the problem is not with the file descriptors. Is it
the max num of sockets?
or maybe the maximum number of files that can be opened?

    Any help would be greatly appreciated.

    I'm using slackware 7.1 - linux 2.4.5

thanx,
marvin




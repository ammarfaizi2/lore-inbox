Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbSIXIxl>; Tue, 24 Sep 2002 04:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261618AbSIXIxl>; Tue, 24 Sep 2002 04:53:41 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:27913 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261617AbSIXIxk>; Tue, 24 Sep 2002 04:53:40 -0400
Message-Id: <200209240850.g8O8odp24965@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andrew Morton <akpm@digeo.com>, Con Kolivas <conman@kolivas.net>
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
Date: Tue, 24 Sep 2002 11:45:05 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0209232236070.27095-100000@coffee.psychology.mcmaster.ca> <1032835551.3d8fd1df2fba0@kolivas.net> <3D8FD580.F1320237@digeo.com>
In-Reply-To: <3D8FD580.F1320237@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 September 2002 01:01, Andrew Morton wrote:
> (And if there's more than a 1% variation between same kernel, compiled
> with different compilers then the test is bust.  Kernel CPU time is
> dominated by cache misses and runtime is dominated by IO wait.
> Quality of code generation is of tiny significance)

Well, not exactly. If it is true that Intel/MS compilers beat GCC
by 30% on code size, 30% smaller kernel ought to make some difference.

However, that will become a GCC code quality benchmark then.
--
vda

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTEPHck (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 03:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbTEPHck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 03:32:40 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:58995 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264363AbTEPHck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 03:32:40 -0400
Date: Fri, 16 May 2003 00:47:07 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [BENCHMARK AIM9] Regressions in 2.5.69
Message-Id: <20030516004707.140b8b11.akpm@digeo.com>
In-Reply-To: <20030505211942.1606.qmail@linuxmail.org>
References: <20030505211942.1606.qmail@linuxmail.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2003 07:45:26.0606 (UTC) FILETIME=[1D7D66E0:01C31B7F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paolo Ciarrocchi" <ciarrocchi@linuxmail.org> wrote:
>
> Hi all/Andrew/Martin,
>  I noticed regression in a few tests,
>  I deleted the results of tests that don't show differences between the two kernel version.
> 
>  Hope it helps.
> 
>  Ciao,
>  		Paolo
>  		
>  2.5.67
>  2.5.69
> 
>  creat-clo 10010 86.8132        86813.19 File Creations and Closes/second
>  creat-clo 10030 22.0339        22033.90 File Creations and Closes/second
>  ^^^^BIG REGRESSION

I cannot repeat any of this.  In fact 2.5.69-mm is a bit faster than
2.5.67.

I tested ext2 mainly.  But a spot-check of creat-clo on reiserfs showed
no regression either.


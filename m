Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbTEKF57 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 01:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTEKF57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 01:57:59 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:47781 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264446AbTEKF56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 01:57:58 -0400
Date: Sat, 10 May 2003 23:11:20 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug on shutdown from 68-mm4
Message-Id: <20030510231120.580243be.akpm@digeo.com>
In-Reply-To: <8880000.1052624174@[10.10.2.4]>
References: <8570000.1052623548@[10.10.2.4]>
	<20030510224421.3347ea78.akpm@digeo.com>
	<8880000.1052624174@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 May 2003 06:10:34.0970 (UTC) FILETIME=[08F1EBA0:01C31784]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> >> Sorry if this is old news, haven't been paying attention for a week.
> >>  Bug on shutdown (just after it says "Power Down") from 68-mm4.
> >>  (the NUMA-Q).
> > 
> > Random guess: is it related to CONFIG_KEXEC?
> 
> Don't think so - I don't have that enabled. Config file is attatched.

It doesn't matter - the kexec patch tends to futz with stuff like that
regardless of CONFIG_KEXEC.

It doesn't happen here.  Could you please retest without the kexec
patch applied?


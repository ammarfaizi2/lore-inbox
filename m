Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbVI1Oag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbVI1Oag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 10:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVI1Oag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 10:30:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35245 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751338AbVI1Oaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 10:30:35 -0400
Date: Wed, 28 Sep 2005 07:29:58 -0700
From: Paul Jackson <pj@sgi.com>
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH 1/3] CPUMETER: add cpumeter framework to the CPUSETS
Message-Id: <20050928072958.1c54ecf6.pj@sgi.com>
In-Reply-To: <20050927113902.C78A570046@sv1.valinux.co.jp>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<20050927113902.C78A570046@sv1.valinux.co.jp>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takahiro-san wrote:
> but the cpu controller code will add some if statements

>From what I read, I suspect that the more interesting question
will be how many additional cache lines and memory pages are
touched, on the most common paths through the scheduler.

However, guessing about performance is a risky business.
Benchmarks will be most helpful for a significant scheduler
patch such as this one.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

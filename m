Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268868AbUIXQJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268868AbUIXQJI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268864AbUIXQJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:09:08 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:62930 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268868AbUIXQJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:09:02 -0400
Date: Fri, 24 Sep 2004 09:07:18 -0700
From: Paul Jackson <pj@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: anton@samba.org, christoph@lameter.com, simon.derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] 1/2 Additional cpuset features
Message-Id: <20040924090718.72bd485d.pj@sgi.com>
In-Reply-To: <20040924144147.GA14367@lnx-holt.americas.sgi.com>
References: <Pine.LNX.4.58.0409101036090.2891@daphne.frec.bull.fr>
	<20040911010808.2b283c9a.pj@sgi.com>
	<Pine.LNX.4.58.0409231238350.11694@server.home>
	<20040923164139.506d65d3.pj@sgi.com>
	<Pine.LNX.4.58.0409231651550.17168@server.home>
	<20040924011751.GA20592@krispykreme>
	<20040924144147.GA14367@lnx-holt.americas.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin wrote:
> Paul, aren't we going to adjust dplace so it uses the user libraries to
> interpret the relative placement ...

Yup - either adjust dplace to accept system numbers, or adjust perfmon
to translate the system numbers that it wants to pass to dplace to
cpuset relative numbers first.  Look at the SGI internal incidents
assigned to Christoph Lameter.  I believe he's assigned this task, and
I'll bet that this is related to his response to Simon's relative cpuset
numbering patch, which started this subthread.  We've come full circle.

We're wandering off the lkml ranch here ... into vendor specific,
user space stuff.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

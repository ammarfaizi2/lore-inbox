Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTKFTHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 14:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263538AbTKFTHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 14:07:10 -0500
Received: from 217-124-6-143.dialup.nuria.telefonica-data.net ([217.124.6.143]:16256
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S263510AbTKFTHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 14:07:07 -0500
Date: Thu, 6 Nov 2003 20:07:03 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Over used cache memory?
Message-ID: <20031106190703.GA2654@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <BAY4-F40qelZScM4qcI00005e31@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY4-F40qelZScM4qcI00005e31@hotmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 06 November 2003, at 17:15:33 +0800,
Wee Teck Neo wrote:

>   procs                      memory      swap          io     system      
> cpu
> r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
> 1  0  0  92744   9640  20240 801644    0    0     3    10   17     0 25  2 10
> 
> The system is having 1GB ram and currently using 92MB as swap. Why does the 
> system use the slower swap when there are still memory available (as 
> cache). Anyway to "force" the system to use more ram instead of putting 
> into swap memory?
> 
The obvious solution is to disable swap memory completely if those 
90 MiB worth of idle and unused memory pages on disk bother you.

If this "vmstat" output shows your box usual load, with 80% of RAM used
in caches, I think you will never really need swap at all.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test9-mm1)

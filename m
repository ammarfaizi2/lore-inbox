Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTENVAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 17:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTENVAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 17:00:06 -0400
Received: from 136.231.118.64.mia-ftl.netrox.net ([64.118.231.136]:16835 "EHLO
	smtp.netrox.net") by vger.kernel.org with ESMTP id S262878AbTENVAD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 17:00:03 -0400
Subject: Re: 2.6 must-fix list, v2
From: Robert Love <rml@tech9.net>
To: shaheed <srhaque@iee.org>
Cc: Felipe Alfaro Solana <yo@felipe-alfaro.com>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200305142201.59912.srhaque@iee.org>
References: <1050146434.3e97f68300fff@netmail.pipex.net>
	 <1052910149.586.3.camel@teapot.felipe-alfaro.com>
	 <1052927975.883.9.camel@icbm>  <200305142201.59912.srhaque@iee.org>
Content-Type: text/plain
Message-Id: <1052946917.883.25.camel@icbm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (1.3.3-2) (Preview Release)
Date: 14 May 2003 17:15:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-14 at 17:01, shaheed wrote:

> Ah. I think I misread your previous note to me on this...that's why my patch 
> modifies init itself (it does not muck with the syscall in any way). I'll try 
> this as soon as I have my 2.5 multiprocessor back. BTW: what are the plans 
> for getting schedutils (and specifically taskset) into a normal 2.6-based 
> distribution? Can I be reasonably sure that this will happen?

I think it is in Debian (unstable at least).

More important to me is getting it into Red Hat and SuSE. I have heard
encouring words from Matt Wilson at Red Hat about schedutils possibly
going into Rawhide soon. It would not hurt to let Red Hat/SuSE/whoever
know that schedutils is something their customers want.

Both Red Hat and SuSE's kernels have the CPU affinity system calls
merged, so you do not need to wait until 2.6 is out to use them.

	Robert Love


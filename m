Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932348AbWFEA2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWFEA2E (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 20:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWFEA2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 20:28:04 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:31877 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932348AbWFEA2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 20:28:01 -0400
Message-ID: <349467272.31863@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Mon, 5 Jun 2006 08:28:07 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: readahead benchmark
Message-ID: <20060605002807.GA4919@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <fengguang.wu@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060604135011.decdc7c9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 01:50:11PM -0700, Andrew Morton wrote:
> readahead-kconfig-options.patch
[...] 
>  It's early days yet - needs heaps more performance testing.  The results
>  from "Linux Portal" <linportal@gmail.com> were discouraging.

I found this mail from the lkml archive, did you happen to have more
results?

------
Date:	Mon, 29 May 2006 17:22:50 +0200
From:	"Linux Portal" <linportal@gmail.com>
To:	linux-kernel@vger.kernel.org
Subject: The adaptive readahead patch benchmark

There is an interesting (although simple) benchmark of Wu's adaptive
readahead patchset (v12) together with graphs here:

  http://linux.inet.hr/adaptive_readahead_benchmark.html

In that simple test it definitely looks promising (3x speedup).

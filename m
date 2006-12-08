Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164242AbWLHBWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164242AbWLHBWM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164338AbWLHBWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:22:11 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:38130 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1164242AbWLHBWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:22:09 -0500
Message-ID: <365540925.17780@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 8 Dec 2006 09:22:12 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: roland <devzero@web.de>
Cc: Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@engr.sgi.com>,
       linux-kernel@vger.kernel.org, lserinol@gmail.com
Subject: Re: I/O statistics per process
Message-ID: <20061208012212.GA5796@mail.ustc.edu.cn>
Mail-Followup-To: roland <devzero@web.de>, Andrew Morton <akpm@osdl.org>,
	Jay Lan <jlan@engr.sgi.com>, linux-kernel@vger.kernel.org,
	lserinol@gmail.com
References: <20060928151409.f0a9bda7.akpm@osdl.org> <0bb201c71a5d$1125a930$eeeea8c0@aldipc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bb201c71a5d$1125a930$eeeea8c0@aldipc>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 08, 2006 at 01:09:01AM +0100, roland wrote:
>
> didn`t discover that there is anything new about this (andrew? jay?) or if
> some other person sent a patch , but i`d like to report that i came across
> a really nice tool which would immediately benefit from per-process i/o
> statistics feature.

Andrew has added kernel support to it in -mm tree.
Check this commit log:
http://www.mail-archive.com/mm-commits@vger.kernel.org/msg02975.html

io-accounting-core-statistics.patch
io-accounting-write-accounting.patch
io-accounting-write-cancel-accounting.patch
io-accounting-read-accounting-2.patch
io-accounting-read-accounting-nfs-fix.patch
io-accounting-read-accounting-cifs-fix.patch
io-accounting-direct-io.patch
io-accounting-report-in-procfs.patch
io-accounting-via-taskstats.patch
io-accounting-add-to-getdelays.patch

Regards,
Fengguang Wu

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbTEBUZI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 16:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbTEBUZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 16:25:07 -0400
Received: from [12.47.58.20] ([12.47.58.20]:49810 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263144AbTEBUZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 16:25:06 -0400
Date: Fri, 2 May 2003 13:34:05 -0700
From: Andrew Morton <akpm@digeo.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm4
Message-Id: <20030502133405.57207c48.akpm@digeo.com>
In-Reply-To: <1051905879.2166.34.camel@spc9.esa.lanl.gov>
References: <20030502020149.1ec3e54f.akpm@digeo.com>
	<1051905879.2166.34.camel@spc9.esa.lanl.gov>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2003 20:37:24.0656 (UTC) FILETIME=[A36A7300:01C310EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
> For what it's worth, kexec has worked for me on the following
> two systems.
> ...
> 00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)

Are you using eepro100 or e100?  I found that e100 failed to bring up the
interface on restart ("failed selftest"), but eepro100 was OK.


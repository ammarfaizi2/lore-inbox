Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTFHBO6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 21:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbTFHBO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 21:14:58 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:59178 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264363AbTFHBO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 21:14:57 -0400
Date: Sat, 7 Jun 2003 18:28:43 -0700
From: Andrew Morton <akpm@digeo.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: rddunlap@osdl.org, colin@colina.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Maximum swap space?
Message-Id: <20030607182843.70079e07.akpm@digeo.com>
In-Reply-To: <20030608005543.GM20413@holomorphy.com>
References: <ltptlqb72n.fsf@colina.demon.co.uk>
	<33435.4.64.196.31.1055008200.squirrel@www.osdl.org>
	<20030607132432.26846b8a.akpm@digeo.com>
	<20030607205046.GL20413@holomorphy.com>
	<20030608005543.GM20413@holomorphy.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jun 2003 01:28:33.0117 (UTC) FILETIME=[464D10D0:01C32D5D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> Santamarta on #kn tested the following patch to allow up to 64
>  swapfiles.

Seems hardly worth the extra arithmetic given that the 2G limit
is actually bogus?

I just did mkswap/swapon of a 52G partition.  That used 26MB of lowmem for
the swap map btw.


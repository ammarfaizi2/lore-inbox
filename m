Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbTFGUKs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 16:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263503AbTFGUKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 16:10:48 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:65053 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263455AbTFGUKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 16:10:47 -0400
Date: Sat, 7 Jun 2003 13:24:32 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: colin@colina.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Maximum swap space?
Message-Id: <20030607132432.26846b8a.akpm@digeo.com>
In-Reply-To: <33435.4.64.196.31.1055008200.squirrel@www.osdl.org>
References: <ltptlqb72n.fsf@colina.demon.co.uk>
	<33435.4.64.196.31.1055008200.squirrel@www.osdl.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jun 2003 20:24:23.0543 (UTC) FILETIME=[C8B51070:01C32D32]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
>  3.  Swap space limits
> 
>  Linux 2.4.10 and later, and Linux 2.5 support any combination of swap
>  files or swap devices to a maximum number of 32 of them.  Prior to Linux
>  2.4.10, the limit was any combination of 8 swap files or swap devices.  On
>  x86 architecture systems, each of these swap areas has a limit of 2 GiB.

The limit is now 16 swapfiles/devices, because one pte bit got
stolen for nonlinear VMA pte's.

I'm not sure where the 2G limit comes from?

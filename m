Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUB0BdT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbUB0BdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:33:19 -0500
Received: from pD9EF044B.dip.t-dialin.net ([217.239.4.75]:48371 "EHLO
	roesrv01.roemling.home") by vger.kernel.org with ESMTP
	id S261672AbUB0BdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:33:17 -0500
Message-ID: <403E9E54.6030404@roemling.net>
Date: Fri, 27 Feb 2004 02:33:08 +0100
From: Jochen Roemling <jochen@roemling.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
References: <1tCuq-3AH-1@gated-at.bofh.it> <1tCEo-3Lh-27@gated-at.bofh.it> <1tDgT-4r2-13@gated-at.bofh.it> <403E87CF.1080409@roemling.net> <20040226160616.E1652@build.pdx.osdl.net> <20040226163236.M22989@build.pdx.osdl.net> <403E958B.6020406@roemling.net> <20040227011151.GT693@holomorphy.com>
In-Reply-To: <20040227011151.GT693@holomorphy.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>Check /proc/sys/vm/nr_hugepages and /proc/sys/kernel/shmmax also.
>  
>
cat /proc/sys/vm/nr_hugepages
64

cat /proc/sys/kernel/shmmax
33554432

cat /proc/meminfo | grep Huge
HugePages_Total:    64
HugePages_Free:     62
Hugepagesize:     4096 kB

but again: root can, users cannot, so sizes won't matter, would they?


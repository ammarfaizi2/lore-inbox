Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbTHUJUF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 05:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTHUJUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 05:20:04 -0400
Received: from gate.corvil.net ([213.94.219.177]:4616 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S262590AbTHUJUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 05:20:02 -0400
Message-ID: <3F448E46.3030403@draigBrady.com>
Date: Thu, 21 Aug 2003 10:17:58 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Theewara Vorakosit <g4685034@alpha.cpe.ku.ac.th>
CC: linux-kernel@vger.kernel.org
Subject: Re: Cloop on Red Hat 9
References: <Pine.LNX.4.33.0308211441500.10179-100000@alpha.cpe.ku.ac.th>
In-Reply-To: <Pine.LNX.4.33.0308211441500.10179-100000@alpha.cpe.ku.ac.th>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theewara Vorakosit wrote:
> Dear All,
> 	I want to create linux distribution on one CD, like Virtual
> Linux. I try to use some compressed file system. I cannot use cramfs
> because supported file size is too small.

Have a look at customising knoppix (which uses cloop), rather than
starting from scratch.

> I try to use cloop but I cannot
> compile on Red Hat 9 with kernel 2.4.20-19.9smp. Here is a error message:

I use cloop_0.68-4.tar.gz sucessfully on redhat 9 (2.4.20-8smp)

I built it like:

make KERNEL_DIR=/usr/src/linux-2.4/ CFLAGS="-DREDHAT_KERNEL -O2"

Pádraig.


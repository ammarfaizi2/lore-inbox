Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265418AbTLHPY5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265421AbTLHPY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:24:56 -0500
Received: from head.linpro.no ([80.232.36.1]:41117 "EHLO head.linpro.no")
	by vger.kernel.org with ESMTP id S265418AbTLHPYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:24:55 -0500
Subject: 2.4: mylex and > 2GB RAM
From: Per Buer <perbu@linpro.no>
Reply-To: perbu@linpro.no
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Linpro AS
Message-Id: <1070897058.25490.56.camel@netstat.linpro.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 08 Dec 2003 16:24:19 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.9 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1ATNFj-0001VR-OP*Ttm8pUE7U2k*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have an Supermicro Superserver (wow!) 8040 or 8060 with a two Intel
Xeon (p3-based with 1MB cache) and a Mylex AcceleRAID 352. We recently
upgraded from 2 to 4GB of memory.

There seems to a problem with IO and high memory. Suddenly IO
performance will degrade dramatically (throughput of about 50KB/s).
Booting the machine with "mem=2048" remedies this.

We have tried replacing the memory with another make - no luck.

Any hints?

-- 
There are only 10 different kinds of people in the world,
those who understand binary, and those who don't.



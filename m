Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUH0LlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUH0LlB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 07:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUH0LlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 07:41:01 -0400
Received: from forte.mfa.kfki.hu ([148.6.72.11]:690 "EHLO forte.mfa.kfki.hu")
	by vger.kernel.org with ESMTP id S263117AbUH0Lk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 07:40:58 -0400
Date: Fri, 27 Aug 2004 13:40:55 +0200
From: Gergely Tamas <dice@mfa.kfki.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: data loss in 2.6.9-rc1-mm1
Message-ID: <20040827114054.GA4467@mfa.kfki.hu>
References: <20040827105543.GA10563@mfa.kfki.hu> <1093604706.5994.54.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093604706.5994.54.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

 > The difference is exactly 4096 bytes, i.e. 1 whole page.  Seems like an
 > off-by-one error somewhere in the file access or page cache code.
 > 
 > It would be interesting to know whether the read is truncated or whether
 > the write is truncated.  So could you tell us what is returned by:
 > 
 > cat testfile | wc -c

$ cat testfile | wc -c
10481664

 > Also your .config would probably be helpful.

[ http://dice.mfa.kfki.hu/dot.config-2.6.9-rc1-mm1.gz ]

Thanks,
Gergely

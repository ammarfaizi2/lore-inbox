Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTGFPpz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 11:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbTGFPpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 11:45:55 -0400
Received: from nils.bezeqint.net ([192.115.106.38]:18861 "EHLO
	nils.bezeqint.net") by vger.kernel.org with ESMTP id S262328AbTGFPpy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 11:45:54 -0400
Date: Sun, 6 Jul 2003 19:00:26 +0300
From: gigag@bezeqint.net
Subject: Re: Patch for 3.5/0.5 address space split
To: lkml <linux-kernel@vger.kernel.org>
Cc: dev@sw.ru
X-Mailer: Webmail Mirapoint Direct 3.3.3-GR
MIME-Version: 1.0
Message-Id: <3927aea9.9f3cdaec.8177f00@mas3.bezeqint.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>As far as I remember I saw some places in the code which 
>should be fixed before split 1/3 can be used. Split 0.5/3.5 can be 
>not-working if you are using PAE-enabled kernel (in some places 
>pgds are copied directly - i.e. 1GB granularity is used).
Right. I've seen a mention on this all over the Net.

Anyway, I'm not using PAE since I have only 4GB of real memory. 
Also, I'm using a patch obtained at 
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2
.4.20pre5aa1/00_3.5G-address-space-5

I need this split to be able to fully utilize the memory for my 
application, which I hope will work. Are you working on the patch 
for 2.4 or 2.5 kernel?

Could anybody suggest a configuration what is working?

Thanks
Giga

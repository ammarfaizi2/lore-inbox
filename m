Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbTHUILa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 04:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbTHUILa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 04:11:30 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:10500 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262512AbTHUIL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 04:11:29 -0400
Subject: Re: Cloop on Red Hat 9
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Theewara Vorakosit <g4685034@alpha.cpe.ku.ac.th>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0308211441500.10179-100000@alpha.cpe.ku.ac.th>
References: <Pine.LNX.4.33.0308211441500.10179-100000@alpha.cpe.ku.ac.th>
Content-Type: text/plain
Message-Id: <1061453484.4678.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 21 Aug 2003 10:11:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-21 at 09:45, Theewara Vorakosit wrote:

> 	I want to create linux distribution on one CD, like Virtual
> Linux. I try to use some compressed file system. I cannot use cramfs
> because supported file size is too small. I try to use cloop but I cannot
> compile on Red Hat 9 with kernel 2.4.20-19.9smp. Here is a error message:

I recommend you trying the latest Red Hat kernel from Rawhide. You can
download the kernel sources from:

ftp://ftp.redhat.com/pub/redhat/linux/rawhide/i386/RedHat/RPMS

look for a package called kernel-source*.rpm, download it, install it
and don't forget to run "make mrproper" before anything else.


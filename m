Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUGFInU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUGFInU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 04:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUGFInU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 04:43:20 -0400
Received: from math.ut.ee ([193.40.5.125]:55788 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S263714AbUGFInS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 04:43:18 -0400
Date: Tue, 6 Jul 2004 11:43:08 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Matt Domsch <Matt_Domsch@dell.com>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: Re: EDD unknown symbols in 2.6.7+BK
In-Reply-To: <20040706021738.GA20540@lists.us.dell.com>
Message-ID: <Pine.GSO.4.44.0407061142040.7146-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I recommend doing a 'bk -r co -q', make clean, make oldconfig, to
> clean up your copy of the tree.

I already did bk -r co -q before reporting it but this alone didn't
help. Now I saved the .config and also did a make mrproper and this
helped. Thanks!

-- 
Meelis Roos (mroos@linux.ee)


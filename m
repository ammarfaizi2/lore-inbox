Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753329AbWK1Ubr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbWK1Ubr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 15:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754278AbWK1Ubr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 15:31:47 -0500
Received: from gw1.cosmosbay.com ([86.65.150.130]:48046 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1753329AbWK1Ubq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 15:31:46 -0500
Message-ID: <456C9CBB.703@cosmosbay.com>
Date: Tue, 28 Nov 2006 21:31:55 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs : reorder some 'struct inode' fields to speedup i_size
 manipulations
References: <20061120151700.4a4f9407@frecb000686>	<20061123092805.1408b0c6@frecb000686>	<20061123004053.76114a75.akpm@osdl.org>	<200611231157.30056.dada1@cosmosbay.com>	<20061127133748.4ebcd6b3.akpm@osdl.org>	<456B5E04.50007@cosmosbay.com> <20061127140131.0353bbca.akpm@osdl.org>
In-Reply-To: <20061127140131.0353bbca.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [86.65.150.130]); Tue, 28 Nov 2006 21:31:42 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :

> This all depends on the offset of the inode, and you don't know what that is.
> 
> offsetof(ext3_inode_info, vfs_inode) != offsetof(nfs_inode, vfs_inode), etc.

Doh... yes you are absolutly right :) I feel dumb now :(


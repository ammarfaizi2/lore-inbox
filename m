Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265013AbUETGlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265013AbUETGlI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 02:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbUETGlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 02:41:08 -0400
Received: from stingr.net ([212.193.32.15]:43221 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S265013AbUETGk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 02:40:58 -0400
Date: Thu, 20 May 2004 10:40:51 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net
Subject: Re: problems with ext3 fs, kernels up to 2.6.6-rc2
Message-ID: <20040520064051.GP19183@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net
References: <20040519104152.GM19183@stingr.net> <20040519170604.GS18086@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20040519170604.GS18086@schnapps.adilger.int>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Andreas Dilger:
> This seems to fix the majority of the problems, although there are still
> some rare failures in the rename test.

Just curious. Is it really doing what it should? Is there are cases
where ext3_delete_entry(handle, old_dir, old_de, old_bh) will be
called twice with the same set of parameters? :()

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head

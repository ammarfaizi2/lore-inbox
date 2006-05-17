Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWEQJK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWEQJK7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 05:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWEQJK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 05:10:59 -0400
Received: from cantor2.suse.de ([195.135.220.15]:25479 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751050AbWEQJK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 05:10:59 -0400
Date: Wed, 17 May 2006 11:10:56 +0200
From: Olaf Hering <olh@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ignore partition table on disks with AIX label
Message-ID: <20060517091056.GA21219@suse.de>
References: <20060517081314.GA20415@suse.de> <200605170853.k4H8rn8K009466@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200605170853.k4H8rn8K009466@turing-police.cc.vt.edu>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, May 17, Valdis.Kletnieks@vt.edu wrote:

> One has to wonder if it might not be better to treat this case as
> "one partition covering the entire disk", or even better, decode the AIX LVM
> info and see if there's any LVM segments present on the disk, so as to limit
> the chances of accidentally splatting live data.

The check can go once someone has implemented proper support to read the
drives. Up to now the bogus partitions cause only confusion and practical
doesnt help anyone. So let it go.

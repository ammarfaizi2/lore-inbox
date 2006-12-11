Return-Path: <linux-kernel-owner+w=401wt.eu-S1763092AbWLKUqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763092AbWLKUqK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 15:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937656AbWLKUqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 15:46:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4395 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1763092AbWLKUqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 15:46:06 -0500
Date: Mon, 11 Dec 2006 21:46:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Artem Bityutskiy <dedekind@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.19-mm1: drivers/mtd/ubi/debug.c: unused variable
Message-ID: <20061211204616.GJ28443@stusta.de>
References: <20061211005807.f220b81c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211005807.f220b81c.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 12:58:07AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc6-mm2:
>...
>  git-ubi.patch
>...
>  git trees.
>...

It doesn't seem to be intended that in ubi_dbg_vprint_nolock() the 
variable "caller" is never assigned any value different from 0.
 
cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


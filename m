Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbULFMJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbULFMJq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 07:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbULFMJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 07:09:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25862 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261505AbULFMJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 07:09:45 -0500
Date: Mon, 6 Dec 2004 13:09:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: 2.6: drivers/md/dm-io.c partially copies bio.c
Message-ID: <20041206120941.GB7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

drivers/md/dm-io.c copies functionality from bio.c .

Is there a specific reason why you don't simply use the functionality 
bio.c provides?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


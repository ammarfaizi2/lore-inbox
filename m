Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWH1Pm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWH1Pm7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 11:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWH1Pm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 11:42:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19103 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750741AbWH1Pm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 11:42:58 -0400
Date: Mon, 28 Aug 2006 17:42:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-pm@osdl.org, Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: T60 not coming out of suspend to RAM
Message-ID: <20060828154242.GB30105@elf.ucw.cz>
References: <20060825110441.GB8538@elf.ucw.cz> <20060828135358.GC24261@mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828135358.GC24261@mellanox.co.il>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-08-28 16:53:58, Michael S. Tsirkin wrote:
> OK, it turns out the problem was with running SATA drive in AHCI mode.
> 
> After applying the following patch from Forrest Zhao
> http://lkml.org/lkml/2006/7/20/56
> both suspend to disk and suspend to ram work fine now.
> This patch is going into 2.6.18, isn't it?

Not sure, check latest -rc5, and if it is not there, ask akpm...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

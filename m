Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbRFWRKB>; Sat, 23 Jun 2001 13:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbRFWRJv>; Sat, 23 Jun 2001 13:09:51 -0400
Received: from ezri.xs4all.nl ([194.109.253.9]:21727 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S261385AbRFWRJj>;
	Sat, 23 Jun 2001 13:09:39 -0400
Date: Sat, 23 Jun 2001 19:09:37 +0200 (CEST)
From: Eric Lammerts <eric@lammerts.org>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add kmalloc check in drviers/pcmcia/rsrc_mgr.c (245-ac16)
In-Reply-To: <20010623152202.B840@jaquet.dk>
Message-ID: <Pine.LNX.4.33.0106231901560.7165-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 23 Jun 2001, Rasmus Andersen wrote:

> +    if (!b) {
> +	printk(" -- aborting.\n");
> +	printk(KERN_ERR "Out of memory.");
> +	return;
> +    }

Why not printk(KERN_ERR "rsrc_mgr: Out of memory.\n"); ?
Then at least people will know what it was that ran out of memory.

Eric


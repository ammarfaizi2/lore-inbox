Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264564AbRFXUww>; Sun, 24 Jun 2001 16:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264567AbRFXUwm>; Sun, 24 Jun 2001 16:52:42 -0400
Received: from ezri.xs4all.nl ([194.109.253.9]:58312 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S264564AbRFXUwd>;
	Sun, 24 Jun 2001 16:52:33 -0400
Date: Sun, 24 Jun 2001 22:52:31 +0200 (CEST)
From: Eric Lammerts <eric@lammerts.org>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add kmalloc check in drviers/pcmcia/rsrc_mgr.c (245-ac16)
In-Reply-To: <20010624214635.C847@jaquet.dk>
Message-ID: <Pine.LNX.4.33.0106242243170.3024-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 24 Jun 2001, Rasmus Andersen wrote:

> Excellent suggestion. How about this one:

> +    if (!b) {
> +       printk(" -- aborting.\n");
> +       printk(KERN_ERR __FUNCTION__ ": Out of memory.");
> +       return;
> +    }

There are zillions of functions called 'init_module' in the kernel.
I think my suggestion was better (and it had a \n at the end!)

Eric


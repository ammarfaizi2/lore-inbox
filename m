Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbREOWRI>; Tue, 15 May 2001 18:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261641AbREOWQ6>; Tue, 15 May 2001 18:16:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18949 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261629AbREOWQw>; Tue, 15 May 2001 18:16:52 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: chip@valinux.com (Chip Salzenberg)
Date: Tue, 15 May 2001 23:12:37 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
In-Reply-To: <20010515144020.H3098@valinux.com> from "Chip Salzenberg" at May 15, 2001 02:40:20 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zn3V-0003CJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wouldn't it be better just to *try* ioctls and see which ones work and
> which ones don't?

1. We have overlaps

2. I've seen code where people play clever ioctl tricks to deduce a device
type and it ends up looking like one of those chemistry identification
charts (hopefully minus do you see smoke ?)

It should be clean and explicit


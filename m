Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267190AbTBTXAK>; Thu, 20 Feb 2003 18:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267229AbTBTXAK>; Thu, 20 Feb 2003 18:00:10 -0500
Received: from havoc.daloft.com ([64.213.145.173]:53917 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267190AbTBTXAI>;
	Thu, 20 Feb 2003 18:00:08 -0500
Date: Thu, 20 Feb 2003 18:10:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       torvalds@transmeta.com, ak@suse.de, davem@redhat.com
Subject: Re: ioctl32 consolidation
Message-ID: <20030220231009.GY9800@gtf.org>
References: <20030220223119.GA18545@elf.ucw.cz> <5.1.0.14.2.20030220145240.0d449118@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030220145240.0d449118@mail1.qualcomm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 02:56:22PM -0800, Max Krasnyansky wrote:
> Eventually we'll be able to kill ugly mess like arch/sparc64/kernel/ioctl32.c.
> That stuff really belongs to the actual subsystems that implement those ioctls.

Yes.

Note that ALSA is already doing it right: sound/core/ioctl32/*

	Jeff




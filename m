Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277435AbRJVBsX>; Sun, 21 Oct 2001 21:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277440AbRJVBsN>; Sun, 21 Oct 2001 21:48:13 -0400
Received: from ns.suse.de ([213.95.15.193]:17169 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S277435AbRJVBsF>;
	Sun, 21 Oct 2001 21:48:05 -0400
Date: Mon, 22 Oct 2001 03:48:39 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.12-ac5
In-Reply-To: <3BD3743C.CF87EE89@delusion.de>
Message-ID: <Pine.LNX.4.30.0110220345410.15374-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001, Udo A. Steinberg wrote:

> Just in order to ensure I'm not insane, could you try building with the
> following .config file?

Ahhh, you're not insane :)
Its the 'IOAPIC=n' case thats throwing it.
Looks like acpitable.c needs a few more ifdef's.

d.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs


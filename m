Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284987AbRLQDfD>; Sun, 16 Dec 2001 22:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284985AbRLQDex>; Sun, 16 Dec 2001 22:34:53 -0500
Received: from ns.suse.de ([213.95.15.193]:2314 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284987AbRLQDek>;
	Sun, 16 Dec 2001 22:34:40 -0500
Date: Mon, 17 Dec 2001 04:34:39 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
Cc: Mandrake kernel list <kernel@mandrakesoft.com>,
        linux-kernel list <linux-kernel@vger.kernel.org>,
        Cooker list <cooker@linux-mandrake.com>
Subject: Re: PATCH: apm.c - runtime parameter for APM Idle call
In-Reply-To: <1008528319.2243.5.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0112170431060.11563-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Dec 2001, Borsenkow Andrej wrote:

> I thought once about run-time detection - if BIOS reports that Idle does
> not slow down CPU try Idle call once and compare jiffies (probably
> repeat several times to be sure). Is it sensible?

A far simpler way would be to add DMI blacklist entries for the BIOSes
that don't do this, although this assumes the problem machine has a DMI
compliant BIOS.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs


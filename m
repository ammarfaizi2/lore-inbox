Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVJRXjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVJRXjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 19:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVJRXjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 19:39:54 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:60578 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932181AbVJRXjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 19:39:54 -0400
Date: Wed, 19 Oct 2005 01:39:34 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Simon Evans <spse@secret.org.uk>, Greg Ungerer <gerg@snapgear.com>,
       "Steven J. Hill" <sjhill@realitydiluted.com>, source@mvista.com,
       David Woodhouse <dwmw2@infradead.org>, jamey.hicks@hp.com,
       Ben Dooks <ben@simtec.co.uk>, Kirk Lee <kirk@hpc.ee.ntu.edu.tw>,
       linux-mtd@lists.infradead.org, Eric Brower <ebrower@usa.net>,
       jzhang@ti.com, Thomas Gleixner <tglx@linutronix.de>,
       Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 03/14] Big kfree NULL check cleanup - drivers/mtd
Message-ID: <20051018233934.GD20236@wohnheim.fh-wedel.de>
References: <200510132126.13411.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200510132126.13411.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 October 2005 21:26:12 +0200, Jesper Juhl wrote:
> 
> This is the drivers/mtd part of the big kfree cleanup patch.
> 
> Remove pointless checks for NULL prior to calling kfree() in drivers/mtd/.
> 
> 
> Sorry about the long Cc: list, but I wanted to make sure I included everyone
> who's code I've changed with this patch.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Acked-by: Jörn Engel <joern@wohnheim.fh-wedel.de>

Jörn

-- 
A surrounded army must be given a way out.
-- Sun Tzu

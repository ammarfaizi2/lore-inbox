Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVJMTnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVJMTnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVJMTnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:43:14 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:64735
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932247AbVJMTnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:43:13 -0400
Subject: Re: [PATCH 03/14] Big kfree NULL check cleanup - drivers/mtd
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200510132126.13411.jesper.juhl@gmail.com>
References: <200510132126.13411.jesper.juhl@gmail.com>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 13 Oct 2005 21:45:12 +0200
Message-Id: <1129232712.1728.704.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-13 at 21:26 +0200, Jesper Juhl wrote:
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

Ack,

tglx






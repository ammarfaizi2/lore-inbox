Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWEOWuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWEOWuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWEOWuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:50:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60141 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750709AbWEOWuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:50:01 -0400
Date: Mon, 15 May 2006 18:49:51 -0400
From: Alan Cox <alan@redhat.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       Moxa Technologies <support@moxa.com.tw>, Martin Mares <mj@ucw.cz>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 2/3] moxa: remove pointless check of 'tty' argument vs NULL
Message-ID: <20060515224951.GA6095@devserv.devel.redhat.com>
References: <200605152357.36018.jesper.juhl@gmail.com> <20060515215901.GB16994@devserv.devel.redhat.com> <9a8748490605151508r4d9da784ib459a1f43fa52d49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490605151508r4d9da784ib459a1f43fa52d49@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 12:08:41AM +0200, Jesper Juhl wrote:
>  >  See? tty was already dereferenced.
> 
> And besides, we wouldn't ever get to the BUG_ON() because even if the
> function did manage to get called it would then explode in the

Agreed - your analysis is right

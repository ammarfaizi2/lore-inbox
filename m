Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264941AbSKEREN>; Tue, 5 Nov 2002 12:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264942AbSKEREN>; Tue, 5 Nov 2002 12:04:13 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:45064 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S264941AbSKEREM>;
	Tue, 5 Nov 2002 12:04:12 -0500
Date: Tue, 5 Nov 2002 18:10:35 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jim Paris <jim@jtan.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
Message-ID: <20021105171035.GB879@alpha.home.local>
References: <20021102013704.A24684@neurosis.mit.edu> <20021103143216.A27147@neurosis.mit.edu> <1036355418.30679.28.camel@irongate.swansea.linux.org.uk> <20021105113020.A5210@neurosis.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105113020.A5210@neurosis.mit.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 11:30:20AM -0500, Jim Paris wrote:
> +		if (count > LATCH) {

may be (count >= LATCH) would be even better ?

Willy

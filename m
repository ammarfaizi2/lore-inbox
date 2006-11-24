Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935032AbWKXUWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935032AbWKXUWI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 15:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935039AbWKXUWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 15:22:08 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:52441 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S935032AbWKXUWF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 15:22:05 -0500
Date: Fri, 24 Nov 2006 20:21:53 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andreas Koensgen <ajk@iehk.rwth-aachen.de>, linux-kernel@vger.kernel.org,
       Willy Tarreau <w@1wt.eu>, akpm@osdl.org
Subject: Re: [PATCH] 6pack: fix "&= !" typo
Message-ID: <20061124202153.GA11858@linux-mips.org>
References: <20061122225856.GB10758@1wt.eu> <20061124185816.GB4973@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061124185816.GB4973@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 09:58:16PM +0300, Alexey Dobriyan wrote:

> Andreas, is this correct?
> ---------------------------------
> SIXP_RX_DCD_MASK is 0x18, so the command below will make cmd 0 always.
> This is likely wrong.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

This one is already merged.

It's funny how long this bug survived - it's in the kernel since the 6pack
driver was first merged that is 2.1 or 2.2 ...

  Ralf

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUHQUN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUHQUN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268401AbUHQUN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:13:26 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:13413 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266683AbUHQUNZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:13:25 -0400
Date: Wed, 18 Aug 2004 00:13:32 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] fix warnings in scripts/binoffset.c
Message-ID: <20040817221332.GB23582@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <20040816202805.356f134d.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816202805.356f134d.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 08:28:05PM -0700, Randy.Dunlap wrote:
> 
> Correct gcc warnings for function return type, printf argument
> types, and signed/unsigned compare.
> 
> Cross-compiled with no warnings/errors for alpha, ia64,
> ppc32, ppc64, sparc32, sparc64, x86_64, and native on i386.
> (-W -Wall)
> 
> [pre-built tool chains are available from:
> http://developer.osdl.org/dev/plm/cross_compile/ ]
> 
> Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

Added to my tree - but..
How am I supposed to build binoffset when I decide
to use extract-config?

	Sam

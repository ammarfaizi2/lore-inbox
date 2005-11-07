Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVKGGjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVKGGjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 01:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbVKGGjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 01:39:12 -0500
Received: from smtp4.brturbo.com.br ([200.199.201.180]:55512 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S964800AbVKGGjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 01:39:10 -0500
Subject: Re: + v4l-720-alsa-support-for-saa7134-that-should-work-fix.patch
	added to -mm tree
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, nshmyrev@yandex.ru, v4l@cerqueira.org
In-Reply-To: <20051106001249.48d3ade0.akpm@osdl.org>
References: <200511060743.jA67hpZa018948@shell0.pdx.osdl.net>
	 <20051106001249.48d3ade0.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 07 Nov 2005 04:39:08 -0200
Message-Id: <1131345548.10094.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Dom, 2005-11-06 às 00:12 -0800, Andrew Morton escreveu:
> akpm@osdl.org wrote:

> Well that didn't work.  The problem is that
> drivers/media/video/saa7134/saa7134-alsa.c doesn't appear to be wired up
> into the build system - it simply doesn't get compiled.
	In fact, it was meant to be part of saa7134 module. We've changed it on the newer patchsets I've sent to you today. It shoud compile well now.

> Please send a fix against next -mm?

	Only after sending I noticed you've released -mm1 (I'm suffering a long
delay on my current ISP - maybe some greylist policy). I'll apply the
patches I sent you today against -mm and, if something wents wrong, I'll
send you some correcting patches.
	
Cheers, 
Mauro.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUCKFLY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 00:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbUCKFLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 00:11:24 -0500
Received: from colin2.muc.de ([193.149.48.15]:35077 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261597AbUCKFLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 00:11:22 -0500
Date: 11 Mar 2004 06:11:20 +0100
Date: Thu, 11 Mar 2004 06:11:20 +0100
From: Andi Kleen <ak@muc.de>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Tom Rini <trini@kernel.crashing.org>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       george@mvista.com, pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Message-ID: <20040311051120.GA25580@colin2.muc.de>
References: <1xpyM-2Op-21@gated-at.bofh.it> <20040310123605.GA62228@colin2.muc.de> <20040310152750.GE5169@smtp.west.cox.net> <200403111027.52534.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403111027.52534.amitkale@emsyssoft.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If we are enforcing this we need to do it correctly: is there any way to check 
> from source code whether binutils version is correct (even a gas check will 
> suffice)

The latest 2.6 kernel has a makefile macro to check the gcc version. You could
probably adapt that to check binutils too.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbUDZQn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUDZQn2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 12:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUDZQn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 12:43:27 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:39887 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262910AbUDZQnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 12:43:03 -0400
Date: Mon, 26 Apr 2004 09:42:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jgarzik@pobox.com, mpm@selenic.com, zwane@linuxpower.ca
Subject: Re: [PATCH] Kconfig.debug family
Message-ID: <20040426164252.GA19246@smtp.west.cox.net>
References: <20040421205140.445ae864.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040421205140.445ae864.rddunlap@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 08:51:40PM -0700, Randy.Dunlap wrote:

> Localizes kernel debug options in lib/Kconfig.debug.
> Puts arch-specific debug options in $ARCH/Kconfig.debug.
[snip]
>  arch/ppc/Kconfig             |  124 -------------------------
>  arch/ppc/Kconfig.debug       |   71 ++++++++++++++

OCP shouldn't be moved into Kconfig.debug, it's just in an odd location
right now.

-- 
Tom Rini
http://gate.crashing.org/~trini/

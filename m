Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270283AbTHLNjX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270325AbTHLNjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:39:23 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:25493 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270283AbTHLNjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:39:22 -0400
Subject: Re: [2.6 patch] add an -Os config option
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030811211145.GA569@fs.tum.de>
References: <20030811211145.GA569@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060695341.21160.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Aug 2003 14:35:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-08-11 at 22:11, Adrian Bunk wrote:
> +config OPTIMIZE_FOR_SIZE
> +	bool "Optimize for size" if EMBEDDED
> +	default n
> +	help
> +	  Enabling this option will pass "-Os" instead of "-O2" to gcc
> +	  resulting in a smaller kernel.
> +
> +	  The resulting kernel might be significantly slower.

With most of the gcc's I tried -Os was faster.


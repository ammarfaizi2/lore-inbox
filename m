Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVDRNBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVDRNBd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 09:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVDRNBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 09:01:33 -0400
Received: from [81.2.110.250] ([81.2.110.250]:59873 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262067AbVDRM77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:59:59 -0400
Subject: Re: [2.6 patch] drivers/net/wan/: possible cleanups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050417234738.GY3625@stusta.de>
References: <20050327143418.GE4285@stusta.de>
	 <1111941516.14877.325.camel@localhost.localdomain>
	 <20050414232028.GD20400@stusta.de>
	 <1113587392.11155.33.camel@localhost.localdomain>
	 <20050417234738.GY3625@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113828904.17058.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 18 Apr 2005 13:55:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-04-18 at 00:47, Adrian Bunk wrote:
> Are there any external drivers using these exports, and if there are, 
> why aren't they in the kernel?

Its a standard API

> If there aren't and someone will at some time in the future need them, 
> re-adding the exports will be trivial.

Really, you will spotaneously magically make them appear in old kernels
that end users have just like that ?

Your argument doesn't hold water. Its an API for drivers so that people
can add 85x30 card drivers using DMA in this fashion. Its an API so they
can add them to *EXISTING* kernels without users being forced to
recompile/wait for the vendor to update their tree/upgrade to a new
release.

Alan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbVCDNHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbVCDNHR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 08:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbVCDNFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 08:05:01 -0500
Received: from [81.2.110.250] ([81.2.110.250]:50139 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262871AbVCDM7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 07:59:55 -0500
Subject: Re: [2.6 patch] unexport console_unblank
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050303215041.GR4608@stusta.de>
References: <20050303215041.GR4608@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109940970.30249.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 04 Mar 2005 12:56:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-03-03 at 21:50, Adrian Bunk wrote:
> I didn't find any possible modular usage of console_unblank in the 
> kernel.
> 

ACK. The oops code is never modular and power management no longer pokes
it directly.


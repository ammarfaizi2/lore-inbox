Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWBIXNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWBIXNs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 18:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWBIXNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 18:13:47 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52201
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750817AbWBIXNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 18:13:47 -0500
Date: Thu, 09 Feb 2006 15:09:39 -0800 (PST)
Message-Id: <20060209.150939.31900700.davem@davemloft.net>
To: heiko.carstens@de.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sparc64: fix syscall table - sys_newfstatat
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060209161040.GD20554@osiris.boeblingen.de.ibm.com>
References: <20060209161040.GD20554@osiris.boeblingen.de.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Thu, 9 Feb 2006 17:10:40 +0100

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> The sparc64 64 bit syscall table seems to be broken as it has
> compat_sys_newfstatat in its syscall table instead of sys_newfstatat.
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Good catch, patch applied.

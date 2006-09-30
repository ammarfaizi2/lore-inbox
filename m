Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWI3KfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWI3KfT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 06:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWI3KfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 06:35:18 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:5102 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750781AbWI3KfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 06:35:15 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 5/6]: powerpc/cell spidernet ethtool -i version number
Date: Sat, 30 Sep 2006 12:35:15 +0200
User-Agent: KMail/1.9.1
Cc: jeff@garzik.org, akpm@osdl.org, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
References: <20060929230552.GG6433@austin.ibm.com> <20060929232625.GM6433@austin.ibm.com>
In-Reply-To: <20060929232625.GM6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609301235.15794.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Saturday 30 September 2006 01:26 schrieb Linas Vepstas:
> This patch moves transmit queue cleanup code out of the
> interrupt context, and into the NAPI polling routine.
>
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Cc: James K Lewis <jklewis@us.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

The subject of this mail should be "spidernet: use NAPI poll for
TX interrupts", otherwise

Acked-by: Arnd Bergmann <arnd@arndb.de>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWEBSan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWEBSan (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 14:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWEBSan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 14:30:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:21748 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964961AbWEBSam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 14:30:42 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
Date: Tue, 2 May 2006 20:30:43 +0200
User-Agent: KMail/1.9.1
Cc: Geoff Levand <geoffrey.levand@am.sony.com>, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
References: <20060429232812.825714000@localhost.localdomain> <200605020150.14152.arnd@arndb.de> <4457A2D6.4070400@am.sony.com>
In-Reply-To: <4457A2D6.4070400@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605022030.44057.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tuesday 02 May 2006 20:20 schrieb Geoff Levand:
> Split the Cell BE support into generic and platform dependent parts.
>
> Creates new config variables PPC_CELL_NATIVE and PPC_IBM_CELL_BLADE.
> The existing CONFIG_PPC_CELL is now used to denote the generic
> Cell processor support.
>
> Also renames spu_priv1.c to spu_priv1_mmio.c.

Ok, looks good now.

> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

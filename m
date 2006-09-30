Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWI3KbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWI3KbW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 06:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWI3KbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 06:31:22 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:64233 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750741AbWI3KbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 06:31:21 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/6]: powerpc/cell spidernet low watermark patch.
Date: Sat, 30 Sep 2006 12:30:59 +0200
User-Agent: KMail/1.9.1
Cc: Linas Vepstas <linas@austin.ibm.com>, jeff@garzik.org, akpm@osdl.org,
       netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org
References: <20060929230552.GG6433@austin.ibm.com> <20060929231730.GJ6433@austin.ibm.com>
In-Reply-To: <20060929231730.GJ6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609301230.59776.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Saturday 30 September 2006 01:17 schrieb Linas Vepstas:
> Implement basic low-watermark support for the transmit queue.
> Hardware low-watermarks allow a properly configured kernel
> to continously stream data to a device and not have to handle
> any interrupts at all in doing so. Correct zero-interrupt
> operation can be actually observed for this driver, when the
> socket buffer is made large enough.

Acked-by: Arnd Bergmann <arnd@arndb.de>

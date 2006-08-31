Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWHaKKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWHaKKM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWHaKJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:09:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44741 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751423AbWHaKJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:09:30 -0400
Subject: Re: [PATCH] rate limiting for the ldisc open faulure messages
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060831094905.GA13400@miraclelinux.com>
References: <20060831094905.GA13400@miraclelinux.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 31 Aug 2006 11:31:40 +0100
Message-Id: <1157020300.6271.249.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-31 am 18:49 +0900, ysgrifennodd Akinobu Mita:
> This patch limits the messages when ldisc open faulures happen.
> It happens under memory pressure.
> 
> Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

Acked-by: Alan Cox <alan@redhat.com>


I'm suprised it ever occurs but the memory pressure case should indeed
be rate limited. Thanks


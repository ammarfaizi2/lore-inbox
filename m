Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWD2Nwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWD2Nwh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 09:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWD2Nwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 09:52:37 -0400
Received: from uproxy.gmail.com ([66.249.92.173]:41032 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750719AbWD2Nwg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 09:52:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h8xZ+9d2TJBANPSobAtxqLGCqUVCQ8DGHYhN8sT9uRqS/LlGK/DlxDFM6fqQkF2Bs1jiQLrSXhefFrcclRwEgvvAx3hV5LlzufHEFLXaB0YZNGrxdFl1TpoAcK4Hi3P5uTiforTMH4H2SriLtbNHbECIFUD3/NJyY/hertiPWcc=
Message-ID: <625fc13d0604290652q3cd325d2hfdd21b8933ad3ce5@mail.gmail.com>
Date: Sat, 29 Apr 2006 08:52:35 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Daniel Drake" <dsd@gentoo.org>
Subject: Re: [PATCH] mtd: SC520CDP should depend on MTD_CONCAT
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org, toralf.foerster@gmx.de
In-Reply-To: <20060429104144.4D7AC87EA56@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060429104144.4D7AC87EA56@zog.reactivated.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/06, Daniel Drake <dsd@gentoo.org> wrote:
> Toralf Förster found a compile error when CONFIG_MTD_SC520CDP=y and
> CONFIG_MTD_CONCAT=n:
>
> drivers/built-in.o: In function `init_sc520cdp':
> sc520cdp.c:(.init.text+0xb4de): undefined reference to `mtd_concat_create'
> drivers/built-in.o: In function `cleanup_sc520cdp':
> sc520cdp.c:(.exit.text+0x14bc): undefined reference to `mtd_concat_destroy'
>
> This patch fixes it.
>
> Signed-off-by: Daniel Drake <dsd@gentoo.org>

I added this in my tree.  Thanks!

josh

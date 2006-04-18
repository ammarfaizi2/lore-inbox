Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWDRN4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWDRN4H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 09:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWDRN4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 09:56:06 -0400
Received: from [81.2.110.250] ([81.2.110.250]:33209 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751031AbWDRN4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 09:56:05 -0400
Subject: Re: [RFC] Get DMA to work for CD/DVD with pdc202xx_old
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tobias Oed <tobiasoed@hotmail.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, andre@linux-ide.org
In-Reply-To: <BAY105-F111271D2374577E2FBCB9FA3C40@phx.gbl>
References: <BAY105-F111271D2374577E2FBCB9FA3C40@phx.gbl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Apr 2006 15:05:34 +0100
Message-Id: <1145369135.18736.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-04-18 at 09:15 -0400, Tobias Oed wrote:
> +       #if 0
>         if ((drive->media != ide_disk) && (speed < XFER_SW_DMA_0))
>                 return -1;
> -
> +       #endif
> +

This change looks unrelated to anything you are trying to do. Rest looks
sane enough


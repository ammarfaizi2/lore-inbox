Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270588AbTGNH5o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 03:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270586AbTGNH5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 03:57:44 -0400
Received: from [81.2.110.254] ([81.2.110.254]:12793 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S270582AbTGNH5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 03:57:38 -0400
Subject: Re: Remove net drivers depending on OBSOLETE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: jgarzik@pobox.com, akpm@digeo.com, linux-net@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030713222945.GC12104@fs.tum.de>
References: <20030713222945.GC12104@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058169900.554.22.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 09:05:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-13 at 23:29, Adrian Bunk wrote:
> The following three net drivers depend in both 2.4 and 2.5 on 
> CONFIG_OBSOLETE:
> - FMV18X
> - SEEQ8005
> - SK_G16
> 
> Since CONFIG_OBSOLETE is never set they are not selectable.
> Is there any reason why they should stay in the kernel or would you 
> accept a patch that removes these drivers?

Seeq hardware turns up now and again, sk_g16 is a pretty rare bit of
hardware but I thought people had it working in current 2.4, fmv18x
I've no idea about. I'll take a look at them


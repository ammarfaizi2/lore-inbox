Return-Path: <linux-kernel-owner+w=401wt.eu-S1751653AbWLMXmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbWLMXmU (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWLMXmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:42:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60716 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbWLMXmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:42:20 -0500
Subject: Re: V4L2: __ucmpdi2 undefined on ppc
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOC.4.61.0612131359430.10721@math.ut.ee>
References: <Pine.SOC.4.61.0612131359430.10721@math.ut.ee>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 13 Dec 2006 21:41:56 -0200
Message-Id: <1166053317.909.19.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qua, 2006-12-13 às 14:11 +0200, Meelis Roos escreveu:
>   MODPOST 618 modules
> WARNING: "__ucmpdi2" [drivers/media/video/v4l2-common.ko] undefined!
> 
> This 32-bit ppc architecture, using gcc version 4.1.2 20061115 
> (prerelease) (Debian 4.1.1-21). .config below if important.
Hmm... does it work with gcc 4.0? 
> 
> __ucmpdi2 seems to be 64-bit comparision. gcc seems to use it for switch 
> statements on 64-bit values.
Argh! if this is caused by switch / ifs, compilation will fail on other
places.

Cheers, 
Mauro.


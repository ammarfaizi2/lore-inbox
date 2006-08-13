Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbWHMAyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbWHMAyW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 20:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWHMAyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 20:54:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54175 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932638AbWHMAyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 20:54:20 -0400
Subject: Re: Neverending module_param() bugs
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, "Ian E. Morgan" <imorgan@webcon.ca>
In-Reply-To: <20060812214709.GC6252@martell.zuzino.mipt.ru>
References: <20060812214709.GC6252@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 12 Aug 2006 21:54:01 -0300
Message-Id: <1155430441.3941.35.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey,

Em Dom, 2006-08-13 às 01:47 +0400, Alexey Dobriyan escreveu:
> P.S.: drivers/media/video/tuner-simple.c:13:module_param(offset, int,
> 0666);

Good catch. We should change it to 0x664. I'll prepare such patch.

Anyway, this is not dangerous, since it just allows an offset adjustment
at tuning frequency of a TV capture board.

Cheers, 
Mauro.


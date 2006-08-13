Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWHMGBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWHMGBa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 02:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWHMGBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 02:01:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16329 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750704AbWHMGB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 02:01:29 -0400
Subject: Re: Neverending module_param() bugs
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       "Ian E. Morgan" <imorgan@webcon.ca>
In-Reply-To: <20060813021938.GN2323@lug-owl.de>
References: <20060812214709.GC6252@martell.zuzino.mipt.ru>
	 <1155430441.3941.35.camel@praia>  <20060813021938.GN2323@lug-owl.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 13 Aug 2006 03:01:05 -0300
Message-Id: <1155448865.3941.37.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Dom, 2006-08-13 às 04:19 +0200, Jan-Benedict Glaw escreveu:
> On Sat, 2006-08-12 21:54:01 -0300, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
> > Em Dom, 2006-08-13 às 01:47 +0400, Alexey Dobriyan escreveu:
> > > P.S.: drivers/media/video/tuner-simple.c:13:module_param(offset, int,
> > > 0666);
> > 
> > Good catch. We should change it to 0x664. I'll prepare such patch.
> 
> But keep in mind it's really octal, not hex.
Ah, sorry for the bad representation :)
> 
> MfG, JBG
> 
Cheers, 
Mauro.


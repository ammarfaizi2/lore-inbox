Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSFXPN4>; Mon, 24 Jun 2002 11:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSFXPNz>; Mon, 24 Jun 2002 11:13:55 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:33809 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S314138AbSFXPNz>;
	Mon, 24 Jun 2002 11:13:55 -0400
Message-ID: <3D173755.8030806@si.rr.com>
Date: Mon, 24 Jun 2002 11:14:29 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24 : drivers/net/defxx.c
References: <Pine.GSO.3.96.1020624103237.22509E-100000@delta.ds2.pg.gda.pl> <3D172A9D.2090904@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to 
http://www.compaq.com/products/quickspecs/10477_na/10477_na.HTML

it explictly states 32-bit DMA addressing. It doesn't state anything to 
suggest 48-bit addressing, which I would think it would if it were possible.

Regards,
Frank

Jeff Garzik wrote:
> Maciej W. Rozycki wrote:
>  >  It's possible DEFPA is not limited to 32-bit addressing.  The board was
>  > designed with Alpha in mind, so it's likely it can address more (and a
>  > brief look at the driver reveals there is room for 48 bits of address in
>  > descriptor entries).
>  >
>  >  Has anyone seen documentation for the board?
> 
> 
> Until we find the docs, I think the patch is fair...
> 
>     Jeff
> 
> 
> 
> 



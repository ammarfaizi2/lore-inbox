Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266849AbUGVLuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266849AbUGVLuE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 07:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266853AbUGVLuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 07:50:04 -0400
Received: from web21105.mail.yahoo.com ([216.136.227.107]:35215 "HELO
	web21105.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266849AbUGVLt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 07:49:59 -0400
Message-ID: <20040722114958.37392.qmail@web21105.mail.yahoo.com>
Date: Thu, 22 Jul 2004 13:49:58 +0200 (CEST)
From: =?iso-8859-1?q?Eva=20Dominguez?= <evadom2002@yahoo.es>
Subject: Re: aditional parallel port problems
To: DervishD <raul@pleyades.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040722112056.GD6148@DervishD>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! you have helped me a lot! I havent solved my
problem yet, but I am not so lost than before :)

> 
>     I cannot help you (by now...), but I'm trying to
> isolate and
> solve my problem with the help of Dino Klein, and as
> soon as I have
> something, I can contact you.

 i would like it so much.

> 
>     Anyway, your card seems to be 'moded' through
> software, am I
> wrong?, so maybe it should work providing in the
> module options the
> io_hi value for the card,
> so the ECR registers are
> accessed and you
> get ECP.

 Reading the documentation of the chip NM9835 I have
seen that bits 7,6,5 of ERP has to be 0 to get a SPP
mode. But ... i dont know the values for the rest of
bits..so I suppose you are saying that i have to write
it:
  
 options parport_pc io=0x378,0x8800 io_hi=0x778,0xNNN
irq=7,5

 NNN: io_hi value for the card....how can I get this
value? you know?


  Thanks a lot again!
  Eva



		
______________________________________________
Yahoo! lanza su nueva tecnología de búsquedas
¿te atreves a comparar?
http://busquedas.yahoo.es

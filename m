Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbVLBAIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbVLBAIG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbVLBAIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:08:05 -0500
Received: from krl.krl.com ([192.147.32.3]:56267 "EHLO krl.krl.com")
	by vger.kernel.org with ESMTP id S932570AbVLBAIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:08:04 -0500
Date: Thu, 1 Dec 2005 19:07:31 -0500
Message-Id: <200512020007.jB207V2V008865@p-chan.krl.com>
From: Don Koch <aardvark@krl.com>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: video4linux-list@redhat.com, perrye@linuxmail.org,
       hartmut.hackmann@t.online.de, linux-kernel@vger.kernel.org,
       gene.heskett@verizon.net, mkrufky@m1k.net
Subject: Re: Gene's pcHDTV 3000 analog problem
In-Reply-To: <1133470859.23362.59.camel@localhost>
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
	<c35b44d70511291548lcb10361ifd3a4ea0f239662d@mail.gmail.com>
	<438CFFAD.7070803@m1k.net>
	<200511300007.56004.gene.heskett@verizon.net>
	<438D38B3.2050306@m1k.net>
	<200511301553.jAUFrSQx026450@p-chan.krl.com>
	<438E7107.3000407@linuxmail.org>
	<438E8365.4020200@linuxmail.org>
	<438E84A4.8000601@m1k.net>
	<438E8A58.4010003@linuxmail.org>
	<438EBD43.3080400@linuxmail.org>
	<438F38E6.7090303@m1k.net>
	<1133470859.23362.59.camel@localhost>
Organization: KRL
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.4.14; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Dec 2005 19:00:59 -0200
Mauro Carvalho Chehab wrote:

> 	After checking the datasheets of Thompson tuner, and I have one guess:
> 
> 	At board description, tda9887 is not there. This tuner needs to work
> properly.
> 
> 	This small patch does enable it for your board.
> 
> 	You should notice that you may need to use some parameters for tda0887
> to work properly, like using port1=0 port2=0 qss=0 as insmod options for
> this module. (these are some on/off bits at the chip, to enable some
> special functions - if 0/0/0 doesn't work you may need to test 0/0/1, ..
> 1/1/1).
> 
> Cheers, 
> Mauro.
> 
Works fine here!  Thanks, Mauro!!

The default settings worked.

-d

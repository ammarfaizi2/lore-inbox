Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272337AbSISSsq>; Thu, 19 Sep 2002 14:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272370AbSISSsp>; Thu, 19 Sep 2002 14:48:45 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:34296
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S272337AbSISSsp>; Thu, 19 Sep 2002 14:48:45 -0400
Subject: Re: [PATCH] In-kernel module loader 1/7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20020919183843.GA16568@kroah.com>
References: <20020919125906.21DEA2C22A@lists.samba.org>
	<Pine.LNX.4.44.0209191532110.8911-100000@serv> 
	<20020919183843.GA16568@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Sep 2002 19:58:15 +0100
Message-Id: <1032461895.27865.54.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-19 at 19:38, Greg KH wrote:
> And with a LSM module, how can it answer that?  There's no way, unless
> we count every time someone calls into our module.  And if you do that,
> no one will even want to use your module, given the number of hooks, and
> the paths those hooks are on (the speed hit would be horrible.)

So the LSM module always says no. Don't make other modules suffer


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278403AbRKNK3Y>; Wed, 14 Nov 2001 05:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279084AbRKNK3N>; Wed, 14 Nov 2001 05:29:13 -0500
Received: from t2.redhat.com ([199.183.24.243]:43772 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S278403AbRKNK3C>; Wed, 14 Nov 2001 05:29:02 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0111140935350.791-100000@vaio> 
In-Reply-To: <Pine.LNX.4.33.0111140935350.791-100000@vaio> 
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Thomas Hood <jdthood@mail.com>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport_pc to use pnpbios_register_driver() 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Nov 2001 10:17:17 +0000
Message-ID: <15273.1005733037@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



kai@tp1.ruhr-uni-bochum.de said:
>  BTW: I think the current logic is useful, as it allows the user to
> specify  in the beginning that he doesn't have an ISA/ISAPNP bus and
> thus gets  never asked for drivers/features he couldn't possibly use.
> But that may be  a matter of taste, and I believe CML2 allows for
> both. 

Then the first set of CML2 rules which get merged should not be changing 
the behaviour of such things - they should be looked at later. The first 
merge of CML2 should have rules which _exactly_ match the existing 
behaviour of CML1. 

--
dwmw2



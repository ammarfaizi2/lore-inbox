Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319694AbSIMPwx>; Fri, 13 Sep 2002 11:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319695AbSIMPww>; Fri, 13 Sep 2002 11:52:52 -0400
Received: from dsl-213-023-022-092.arcor-ip.net ([213.23.22.92]:42639 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319694AbSIMPwu>;
	Fri, 13 Sep 2002 11:52:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] Raceless module interface
Date: Fri, 13 Sep 2002 17:59:44 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
References: <20020913080709.9026B2C054@lists.samba.org>
In-Reply-To: <20020913080709.9026B2C054@lists.samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17psrB-0008Ao-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 08:51, Rusty Russell wrote:
> In message <E17pg3H-0007pb-00@starship> you write:
> > The same with the entrenched separation at the user level between
> > create and init module: what does it give you that an error exit
> > from a single create/init would not?
> 
> That's done for entirely different reasons, as the userspace linker
> needs to know the address of the module.

Thanks for clearing that up.  Perhaps a callback would have been
better, but it's obviously moot now.

-- 
Daniel

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVLBNe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVLBNe6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 08:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVLBNe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 08:34:58 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:59293 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750706AbVLBNe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 08:34:57 -0500
Subject: Re: Use enum to declare errno values
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Denis Vlasenko <vda@ilport.com.ua>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Jackson <pj@sgi.com>, francis_moreau2000@yahoo.fr,
       linux-kernel@vger.kernel.org
In-Reply-To: <2cd57c900512020456n2f31101k@mail.gmail.com>
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>
	 <20051123233016.4a6522cf.pj@sgi.com>
	 <Pine.LNX.4.61.0512011458280.21933@chaos.analogic.com>
	 <200512020849.28475.vda@ilport.com.ua>
	 <2cd57c900512020127m5c7ca8e1u@mail.gmail.com>
	 <84144f020512020418x7ebf5e3bt54cde14ec6a7a954@mail.gmail.com>
	 <2cd57c900512020456n2f31101k@mail.gmail.com>
Date: Fri, 02 Dec 2005 15:34:53 +0200
Message-Id: <1133530493.9240.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/2, Pekka Enberg <penberg@cs.helsinki.fi>:
> > I don't follow your reasoning. The naming collision is a real problem
> > with macros. With enum and const, the compiler can do proper checking
> > with meaningful error messages. Please explain why you think #define
> > is better for Denis' example?

On Fri, 2005-12-02 at 20:56 +0800, Coywolf Qi Hunt wrote:
> That is a bad bad style. It should be `#define FOO 123' if you have to
> write it.

Fair enough. And when you have two colliding constants, macros are
superior, because...?

			Pekka


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277313AbRJRA0D>; Wed, 17 Oct 2001 20:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277377AbRJRAZx>; Wed, 17 Oct 2001 20:25:53 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:18699 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S277313AbRJRAZl>;
	Wed, 17 Oct 2001 20:25:41 -0400
Message-Id: <200110180025.f9I0Ps8t004928@sleipnir.valparaiso.cl>
To: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
cc: Paul Gortmaker <p_gortmaker@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Making diff(1) of linux kernels faster 
In-Reply-To: Message from =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr> 
   of "Wed, 17 Oct 2001 19:57:52 +0200." <20011017175752.80489.qmail@web20507.mail.yahoo.com> 
Date: Wed, 17 Oct 2001 21:25:53 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr> said:

[...]

> Be very careful not to modify a multi-linked file, or
> it will be damaged in all trees and won't be seen by
> diff. your editor must unlink before saving.

Most don't. ed(1), vi(1) and emacs(1) are careful tro write to the very
same file. jed(1) is the only outlier I'm aware of...
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616

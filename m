Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVJJE3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVJJE3V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 00:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVJJE3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 00:29:21 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:52182 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932342AbVJJE3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 00:29:20 -0400
Message-Id: <200510091538.j99FcFmW005439@inti.inf.utfsm.cl>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: linux-kernel@vger.kernel.org,
       Linux Visionaries Mailing List <lvml@lists.blackwhale.net>
Subject: Re: Why no XML in the Kernel? 
In-Reply-To: Message from Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
   of "Sat, 08 Oct 2005 02:34:57 +0100." <20051008013457.GR18797@lkcl.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 09 Oct 2005 12:38:15 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:

[...]

>  it's a friggin sight better than contemplating XML, but it also comes
>  with a price tag: in this case, nearly 70,000 lines of library code
>  that "encapsulates" and "extracts" the data structures for you, at
>  runtime [yes, you can supply your own malloc and free routines]

70 KSLOC is a /lot/, the benefit of having that in kernel would have to be
very large to justify it. And in the frame of an operating system that
believes in flat ("just stream of bytes") interfaces throughout and
hopefully very simple tools on top ("cat", "more", "grep") that are
combined by the user to do complex stuff I just don't see it.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513


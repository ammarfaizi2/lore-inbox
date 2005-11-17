Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVKQXkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVKQXkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbVKQXkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:40:31 -0500
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:45890 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964898AbVKQXkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:40:31 -0500
Date: Thu, 17 Nov 2005 23:40:27 +0000 (GMT)
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: =?ISO-8859-1?Q?St=E9phane_BAUSSON?= <stephane.bausson@free.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fail to buil linux-2.6.14
In-Reply-To: <437CF690.5060206@free.fr>
Message-ID: <Pine.LNX.4.63.0511172335570.15546@deepthought.mydomain>
References: <437CF690.5060206@free.fr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-1049896897-1132270827=:15546"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-1049896897-1132270827=:15546
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 17 Nov 2005, Stéphane BAUSSON wrote:

> Hi, I am failing to build 2.6.14, any idea or direction for investigation ?
>
> ======================================
> /local/gnu/binutils/bin/ld: section .text [ffffe400 -> ffffe45f] overlaps 
> section .dynstr [ffffe17c -> ffffe9cd]
> /local/gnu/binutils/bin/ld: section .note [ffffe460 -> ffffe477] overlaps 
> section .dynstr [ffffe17c -> ffffe9cd]

  Get a better binutils ?  I don't know what you've installed in 
/local/gnu/binutils, but it clearly doesn't get along with the kernel 
you've compiled.  Maybe it's broken (at least from a kernel viewpoint), 
maybe it simply doesn't match the version of gcc you are using.

Ken
-- 
  das eine Mal als Tragödie, das andere Mal als Farce

---1463809536-1049896897-1132270827=:15546--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267856AbUIMRaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267856AbUIMRaM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 13:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268733AbUIMR2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 13:28:09 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:45037 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S268346AbUIMR1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 13:27:07 -0400
Date: Mon, 13 Sep 2004 19:26:57 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: hugh@veritas.com, zam@namesys.com, pj@sgi.com, wli@holomorphy.com,
       reiser@namesys.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined   
 atomic_sub_and_test
In-Reply-To: <20040913171435.GA3566@mschwid3.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.61.0409131925100.877@scrub.home>
References: <20040913171435.GA3566@mschwid3.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Sep 2004, Martin Schwidefsky wrote:

> Well, adding the missing s390 atomic operations is easy (see patch).
> But I really doubt that it will make a measurable difference in
> performance on ANY architecture.

On some archs atomic_sub_return is more complex than atomic_sub_and_test 
and there it does make a difference.

bye, Roman

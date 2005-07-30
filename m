Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbVG3VMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbVG3VMD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 17:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVG3VMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 17:12:02 -0400
Received: from dani.dds.nl ([213.196.11.18]:56247 "EHLO dani.dds.nl")
	by vger.kernel.org with ESMTP id S262766AbVG3VLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 17:11:53 -0400
From: Willem de Bruijn <wdb@few.vu.nl>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: status of kernel memory debugging?
Date: Sat, 30 Jul 2005 23:12:06 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200507301323.28083.wdb@few.vu.nl> <20050730151432.GA3524@ccure.user-mode-linux.org>
In-Reply-To: <20050730151432.GA3524@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507302312.09384.wdb@few.vu.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> UML is still too strange for valgrind, despite progress on both sides
> (valgrind accepting more strange things and UML becoming less
> strange).
>
> I tried grinding UML a month or so ago, and its use of clone was a
> sticking point.
>

I think I read your remark, yes. Thanks for the update; I hoped some strides 
had been made in that direction since then. Personally,  I know to little 
about the topic to be of any use.

I guess the best option is then using slab caches per object type, so that I 
can at least find obvious memory leaks. 

On a sidenote, it'll be interesting to see what valgrind reports once (if?) 
the kernel gets a good grinding. 

Willem

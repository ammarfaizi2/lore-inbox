Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267254AbTBIM1c>; Sun, 9 Feb 2003 07:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267259AbTBIM1c>; Sun, 9 Feb 2003 07:27:32 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:12932 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP
	id <S267254AbTBIM1b>; Sun, 9 Feb 2003 07:27:31 -0500
Message-ID: <3E465B03.19AF64B9@free.fr>
Date: Sun, 09 Feb 2003 14:43:31 +0100
From: Jerome de Vivie <jerome.devivie@free.fr>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap inside kernel memory.
References: <3E45A7C4.8F1EBDFA@free.fr> <Pine.LNX.4.50L.0302082159460.12742-100000@imladris.surriel.com>
	 <3E45B3FF.E687EF48@free.fr> <Pine.LNX.4.50L.0302082350190.12742-100000@imladris.surriel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Sun, 9 Feb 2003, Jerome de Vivie wrote:
> 
> > Here, do_mmap check if the addresse match inside current process and
> > return me -ENOMEM. Are there others functions which i could use to
> > associate this file and a vmalloc'ed space ?
> 
> As I said, you don't want to mmap a file in kernel memory.
> You only have 128 MB of vmalloc space and you don't want to
> waste it.
> 
> If you know which addresses within the file you want to
> access, why don't you access them through the page cache
> functions ?

Ok. I will go through the page cache.

regards,

j.

-- 
Jérôme de Vivie

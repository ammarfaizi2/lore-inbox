Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317290AbSFCGTT>; Mon, 3 Jun 2002 02:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317291AbSFCGTS>; Mon, 3 Jun 2002 02:19:18 -0400
Received: from [195.63.194.11] ([195.63.194.11]:31241 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317290AbSFCGTS>; Mon, 3 Jun 2002 02:19:18 -0400
Message-ID: <3CFAFCB0.5030304@evision-ventures.com>
Date: Mon, 03 Jun 2002 07:20:48 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TRIVIAL: rwhron@earthlink.net: remove space in cache
 names
In-Reply-To: <E17El4U-0007ha-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> rwhron@earthlink.net: remove space in _proc_slabinfo cache_name:
>   Most /proc/slabinfo cache_names are in the format:
>   cache_name.  There are a couple with spaces in the
>   name, which is inconsistent and requires a special case
>   when scripting.
>   
>   Changes "fasync cache" and "file lock cache" to have
>   the usual underscore.
>   
>   Tested on 2.5.18.  Applies to 2.4.19-pre8 with offset.


If you are looking in this area already plese remove
the completely redundant and inconsistently used cache
suffix for some entry names too. Slabinfo is about allocation
caches and nothing else.


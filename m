Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266152AbUAGJ0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 04:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266156AbUAGJ0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 04:26:17 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:33989 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S266152AbUAGJ0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 04:26:11 -0500
Message-ID: <3FFBD0B1.50909@namesys.com>
Date: Wed, 07 Jan 2004 12:26:09 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@linuxhacker.ru>
CC: linux-kernel@vger.kernel.org, mfedyk@matchmail.com,
       Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related
 to sector_t being unsigned, advice requested
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk> <3FFA7717.7080808@namesys.com> <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk> <20040106174650.GD1882@matchmail.com> <200401062135.i06LZAOY005429@car.linuxhacker.ru> <3FFB46B0.9060101@namesys.com> <20040106235335.GC415627@linuxhacker.ru>
In-Reply-To: <20040106235335.GC415627@linuxhacker.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:

>
>
>As for why gcc is finding this, but scripts (e.g. smatch) do not is because
>scripts generally know nothing about variable types, so they cannot tell
>this comparison was always false (and since gcc can do this for long time
>already, there is no point in implementing it in scripts anyway).
>  
>
can we get gcc to issue us a warning?  there might be other stuff 
lurking around also....


-- 
Hans



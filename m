Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUBZBG2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 20:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbUBZBG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 20:06:27 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:39555 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262585AbUBZBG0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 20:06:26 -0500
Message-ID: <403D468D.2090901@cyberone.com.au>
Date: Thu, 26 Feb 2004 12:06:21 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<403BCE9E.7080607@matchmail.com> <20040224143025.36395730.akpm@osdl.org> <403D1347.8090801@matchmail.com>
In-Reply-To: <403D1347.8090801@matchmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:

>>
>>> What about Nick's fix up patch for the two patches above?  Should I 
>>> include that one also?
>>
>
> I'm running 2.6.3-mm3-486-fazok (nick's patch), and it has improved my 
> slab usage greatly.  It was averaging 500MB-700MB slab.  Now slab is 
> ~230MB, and page cache is ~700MB
>

That is a much better sounding ratio. Of course that doesn't mean much
if performance is worse. Slab might be getting reclaimed a little bit
too hard vs pagecache now.

> See:
> http://www.matchmail.com/stats/lrrd/matchmail.com/srv-lnx2600.matchmail.com-memory.html 
>
>
> Is there any way I can get the VM patches against 2.6.3?  I'm not 
> comfortable with running -mm3 on this production server, especially 
> seeing the "sync hang" bug.
>

Well your server wasn't going too badly with 2.6.3, wasn't it? Might
as well just wait for them to get into the the tree.


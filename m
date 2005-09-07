Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbVIGUzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVIGUzf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 16:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVIGUzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 16:55:35 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:60293 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751315AbVIGUzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 16:55:35 -0400
Message-ID: <431F53B6.6000805@gmail.com>
Date: Wed, 07 Sep 2005 22:55:18 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org, Grant Coady <lkml@dodo.com.au>
Subject: Re: Some warnings and stuff GCC 4
References: <431F292D.3070705@comcast.net>
In-Reply-To: <431F292D.3070705@comcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser napsal(a):

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>I get lots of warnings building my kernel.  I've attached my .config;
>I'm using a kernel I downloaded from kernel.org, unpatched.
>  
>
[snip]

>. . . one of the V4L drivers failed to build too, I turned it off.
>
>
>drivers/media/video/zr36120.c: At top level:
>drivers/media/video/zr36120.c:1821: error: unknown field 'open'
>specified in initializer
>drivers/media/video/zr36120.c:1821: warning: initialization makes
>integer from pointer without a cast
>drivers/media/video/zr36120.c:1822: error: unknown field 'close'
>specified in initializer
>drivers/media/video/zr36120.c:1822: warning: initialization from
>incompatible pointer type
>drivers/media/video/zr36120.c:1823: error: unknown field 'read'
>specified in initializer
>drivers/media/video/zr36120.c:1823: warning: initialization from
>incompatible pointer type
>drivers/media/video/zr36120.c:1824: error: unknown field 'write'
>specified in initializer
>drivers/media/video/zr36120.c:1824: warning: initialization from
>incompatible pointer type
>drivers/media/video/zr36120.c:1825: error: unknown field 'poll'
>specified in initializer
>drivers/media/video/zr36120.c:1826: error: unknown field 'ioctl'
>specified in initializer
>
>  
>
<cite source="http://lkml.org/lkml/2005/7/29/302">

On Fri, 29 Jul 2005 18:40:46 -0300, Mauro Carvalho Chehab <mchehab@brturbo.com.br> wrote:
>>>>drivers/media/video/zr36120.c
>>>>drivers/media/video/zr36120_i2c.c
>>>>drivers/media/video/zr36120_mem.c
>> 
>> 
>> Being discussed on the V4L list
>	It seems that nobody are interested on maintaining it. No answer from
>V4L list subscribers.
>
>	I think it may be removed.

Please no, I'll get to it, I have one to play with.
Grant.

</cite>
So, Grant, are you doing something with that or could we schedule it for 
wiping out?

regards,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10


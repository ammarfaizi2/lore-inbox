Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262448AbSLCRkh>; Tue, 3 Dec 2002 12:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262648AbSLCRkh>; Tue, 3 Dec 2002 12:40:37 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:62310 "EHLO xsmtp.ethz.ch")
	by vger.kernel.org with ESMTP id <S262448AbSLCRkg>;
	Tue, 3 Dec 2002 12:40:36 -0500
Message-ID: <3DECEE53.2030003@debian.org>
Date: Tue, 03 Dec 2002 18:48:03 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en, it-ch, it, fr
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
References: <fa.l4d1mqv.1ghm1h2@ifi.uio.no> <fa.j8nq6dv.14lihor@ifi.uio.no> <3DEC6F41.9000106@debian.org> <3DECECAB.3030308@zytor.com>
In-Reply-To: <3DECECAB.3030308@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Dec 2002 17:48:06.0415 (UTC) FILETIME=[22AB61F0:01C29AF4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



H. Peter Anvin wrote:
> Giacomo Catenazzi wrote:
> 
>>
>> kprintf would be better
> 
>  >
> 
> Why?  We don't have, say, kstrcpy() or ksscanf() for other functions 
> that are library-equivalent.

k to remember people that it is not the std function, thus not a write to
the standard output. I see more like fprintf (file) and [v]sprintf (string),
we write to a special buffer ("klog").
But if we don't move the verbosity level out of string, also the simple
'printf' would be fine.

ciao
	giacomo


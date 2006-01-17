Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWAQDkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWAQDkw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 22:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWAQDkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 22:40:52 -0500
Received: from sandeen.net ([209.173.210.139]:31095 "EHLO mail.sandeen.net")
	by vger.kernel.org with ESMTP id S1751255AbWAQDkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 22:40:52 -0500
Message-ID: <43CC673B.8050808@sgi.com>
Date: Mon, 16 Jan 2006 21:40:43 -0600
From: Eric Sandeen <sandeen@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Macintosh/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: xfs: Makefile-linux-2.6 => Makefile?
References: <20060109164214.GA10367@mars.ravnborg.org> <20060109164611.GA1382@infradead.org> <43C2CFBD.8040901@sgi.com> <20060109234532.78bda36a.akpm@osdl.org> <43C3E222.7020203@sgi.com> <20060116231952.GA8752@mars.ravnborg.org>
In-Reply-To: <20060116231952.GA8752@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
>>Sam, is there any way to make this work with some code for the module in a 
>>subdirectory?
> 
> 
> Hi Eric.
> I forgot to point out one ugly solution for this.
> You can include a dummy Kbuild (Makefile) in each directory to support
> this. I recall that reiser4 had similar question and this was the
> solution I pointed out for them too.
> No - I am not in favour of it. But for local development it could make
> sense.
> So it may solve the "Eric" part of it, but not the "Andrew" part of it
> since these file will never get in the mainstream kernel (hopefully).
> 
> 	Sam

Thanks, Sam - I'd considered that, too.  We may do it locally.

-Eric

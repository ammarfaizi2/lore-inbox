Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751809AbWF2MCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbWF2MCd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 08:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbWF2MCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 08:02:33 -0400
Received: from mail.gmx.net ([213.165.64.21]:4995 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751809AbWF2MCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 08:02:32 -0400
X-Authenticated: #342784
From: jensmh@gmx.de
To: Paolo Ornati <ornati@gmail.com>
Subject: Re: [PATCH] Documentation: remove duplicate cleanups
Date: Thu, 29 Jun 2006 14:02:18 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, Paolo Ornati <ornati@fastwebnet.it>
References: <20060629134002.1b06257c@localhost>
In-Reply-To: <20060629134002.1b06257c@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606291402.21287.jensmh@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati writes:

> diff --git a/Documentation/block/as-iosched.txt b/Documentation/block/as-iosched.txt
> index 6f47332..ed24cdd 100644
> --- a/Documentation/block/as-iosched.txt
> +++ b/Documentation/block/as-iosched.txt
> @@ -111,7 +111,7 @@ or if the next request in the queue is "
>  just completed request, it is dispatched immediately.  Otherwise,
>  statistics (average think time, average seek distance) on the process
>  that submitted the just completed request are examined.  If it seems
> -likely that that process will submit another request soon, and that

old version is correct, I think.

> +likely that process will submit another request soon, and that
>  request is likely to be near the just completed request, then the IO
>  scheduler will stop dispatching more read requests for up time (antic_expire)
>  milliseconds, hoping that process will submit a new request near the one


> diff --git a/Documentation/exception.txt b/Documentation/exception.txt
> index 3cb39ad..75aaa6e 100644
> --- a/Documentation/exception.txt
> +++ b/Documentation/exception.txt
> @@ -10,7 +10,7 @@ int verify_area(int type, const void * a
>  function (which has since been replaced by access_ok()).
>  
>  This function verified that the memory area starting at address 
> -addr and of size size was accessible for the operation specified 

maybe old version is correct.

> +addr and of size was accessible for the operation specified
>  in type (read or write). To do this, verify_read had to look up the 
>  virtual memory area (vma) that contained the address addr. In the 
>  normal case (correctly working program), this test was successful. 
> diff --git a/Documentation/fb/fbcon.txt b/Documentation/fb/fbcon.txt
> index f373df1..4a9739a 100644
> --- a/Documentation/fb/fbcon.txt
> +++ b/Documentation/fb/fbcon.txt
> @@ -150,7 +150,7 @@ C. Boot options
>  
>  C. Attaching, Detaching and Unloading
>  
> -Before going on on how to attach, detach and unload the framebuffer console, an

not sure here, I'm not a native english speaker.

> +Before going on how to attach, detach and unload the framebuffer console, an
>  illustration of the dependencies may help.
>  


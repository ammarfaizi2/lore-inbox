Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263933AbTDHEkj (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 00:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263935AbTDHEkj (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 00:40:39 -0400
Received: from air-2.osdl.org ([65.172.181.6]:31703 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263933AbTDHEki (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 00:40:38 -0400
Message-ID: <32918.4.64.197.106.1049777532.squirrel@webmail.osdl.org>
Date: Mon, 7 Apr 2003 21:52:12 -0700 (PDT)
Subject: Re: [PATCH] Wanted: a limit on kernel log buffer size
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <76306.1226@compuserve.com>
In-Reply-To: <200304080045_MC3-1-3378-3CDB@compuserve.com>
References: <200304080045_MC3-1-3378-3CDB@compuserve.com>
X-Priority: 3
Importance: Normal
Cc: <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>,
       <zippel@linux-m68k.org>
X-Mailer: SquirrelMail (version 1.2.11 [cvs])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Randy Dunlap wrote:
>
>
>>Here's a [modified] patch that limits kernel log buffer size
>>to 1 MB max and 4 KB min.
>
>
>  That's even better.
>
>  Maybe the kernel config system could just use multi-choice,
> something like this?
>
>    ( )   8K
>    ( )  16K
>    ( )  32K
>    ( )  64K
>    ( ) 128K
>    ( ) 256K
>
> A subset of your larger range should be enough, and this
> would be less prone to user error.

Yes, that could be done.  In fact, the current LOG BUFFER size
selection started out that way IIRC, but some people said things
like, "why have limits" and "make it more general," so I did,

I guess now we have an answer to "why have limits."  :(
If more people keep having problems with it, we should change it.

~Randy




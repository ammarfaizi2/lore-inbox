Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWAALeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWAALeK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 06:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWAALeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 06:34:10 -0500
Received: from mail.gmx.net ([213.165.64.21]:51586 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751107AbWAALeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 06:34:09 -0500
X-Authenticated: #1226656
Date: Sun, 1 Jan 2006 12:37:29 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Howto set kernel makefile to use particular gcc
Message-ID: <20060101123729.09c5d76c@vaio.gigerstyle.ch>
In-Reply-To: <23377.1136114307@ocs3.ocs.com.au>
References: <20060101121303.488e634b@vaio.gigerstyle.ch>
	<23377.1136114307@ocs3.ocs.com.au>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith, your domain seems not to be resolvable...

On Sun, 01 Jan 2006 22:18:27 +1100
Keith Owens <kaos@ocs.com.au> wrote:

> Marc Giger (on Sun, 1 Jan 2006 12:13:03 +0100) wrote:
> >Why would you "hardwire" it?
> >#export CC="distcc"
> >should do it.
> 
> Doubt it.  From 'info make', Node: Environment.
> 
>    Variables in `make' can come from the environment in which `make'
>    is
>   run.  Every environment variable that `make' sees when it starts up
>   is transformed into a `make' variable with the same name and value.
>   But an explicit assignment in the makefile, or with a command
>   argument, overrides the environment.  (If the `-e' flag is
>   specified, then values from the environment override assignments in
>   the makefile.  *Note Summary of Options: Options Summary.  But this
>   is not recommended practice.)
> 
> The kernel Makefile explicitly sets CC which overrides the environment
> value, but does not override a command line definition of CC.  IOW, do
> not reply on environment variables always working with make.

You are absolutely right. Because I never used it in this way, I wrote
"should":-) I specify it always on the make command line.

So if Kalin would like to hardwire it, he has to change the CC variable
in the Makefile...

Thank you

Marc

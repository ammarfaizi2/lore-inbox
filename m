Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280693AbRKBN5h>; Fri, 2 Nov 2001 08:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280696AbRKBN51>; Fri, 2 Nov 2001 08:57:27 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:49629 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S280695AbRKBN5R>; Fri, 2 Nov 2001 08:57:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Date: Fri, 2 Nov 2001 14:59:58 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <15zGYm-1gibkeC@fmrl05.sul.t-online.com> <20011102132014.41f2d90a.rusty@rustcorp.com.au>
In-Reply-To: <20011102132014.41f2d90a.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15zeoa-0RBdnkC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 November 2001 03:20, Rusty Russell wrote:
> 	I'm not sure about such explicit typing: see my patch (the existing types
> are only for convenience: you can trivially supply your own).  I agree with
> the "one file, one value" idea.  I also went for dynamic directories for
> those who don't want to continually register/deregister.

Explicit typing has a few advantages for the user. User-space apps could use 
a ioctl to get the type (and for enums the possible values, for integers 
maybe a value range). Then you can write some program that shows the user the 
possible values of each file, so you don't have to keep them in mind. And you 
can easily write a GUI administration tool that allows you to modify kernel 
and driver parameters. 
It would also make it possible to convert the content of the filesystem into 
another format, for example you could automatically generate a XML Schema 
definition. IMHO persistence is a desirable feature for the editable files.
 
bye...

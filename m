Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSJVAzw>; Mon, 21 Oct 2002 20:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSJVAzw>; Mon, 21 Oct 2002 20:55:52 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:35089 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S261907AbSJVAzv>; Mon, 21 Oct 2002 20:55:51 -0400
Date: Mon, 21 Oct 2002 18:01:48 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: System call wrapping
Message-ID: <20021022010148.GA31385@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1035222121.1063.20.camel@pc177> <Pine.LNX.4.44L.0210211812240.22993-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210211812240.22993-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 06:14:48PM -0200, Rik van Riel wrote:
> Maybe you could use the Linux Security Module hooks for
> open() and exec() to pass a request to your virus scan
> software ?
> 
> Note that this kernel module needs to be GPL, due to the
> fact that it's a derived work of the kernel itself. This
> only applies to the kernel module that asks the virus
> scanner to check the files for virusses, not necessarily
> the virus scanner itself.

Even _if_ Rik is overstating this (I'm inclined to agree
with him).  You will have an issue with kernel tainting.

If you don't make your module GPL compatible then your users
will have to look to you for kernel support.  And you can
argue with nvidia about which of you supports the shared
customers.  Or you can tell your customers you don't support
them if they use any other modules that are on the same
license terms as your own.

I enjoy the idea that installing a virus scanner will TAINT
the kernel.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRCLKq3>; Mon, 12 Mar 2001 05:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129740AbRCLKqT>; Mon, 12 Mar 2001 05:46:19 -0500
Received: from nas11-222.wms.club-internet.fr ([213.44.38.222]:61679 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S129733AbRCLKqJ>;
	Mon, 12 Mar 2001 05:46:09 -0500
Message-Id: <200103121043.LAA01204@microsoft.com>
Subject: Re: Hashing and directories
From: Xavier Bestel <xavier.bestel@free.fr>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <200103121005.f2CA5wg29762@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution (0.9/+cvs.2001.03.06.23.22 - Preview Release)
Date: 12 Mar 2001 11:43:13 +0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12 Mar 2001 21:05:58 +1100, Herbert Xu a écrit :
> Pavel Machek <pavel@suse.cz> wrote:
> 
> > xargs is very ugly. I want to rm 12*. Just plain "rm 12*". *Not* "find
> > . -name "12*" | xargs rm, which has terrible issues with files names
> 
> Try
> 
> printf "%s\0" 12* | xargs -0 rm

Or find -print0 ... | xargs -0 ...

Xav


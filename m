Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135372AbRDZMgT>; Thu, 26 Apr 2001 08:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135386AbRDZMgJ>; Thu, 26 Apr 2001 08:36:09 -0400
Received: from belcebu.upc.es ([147.83.2.63]:52939 "EHLO belcebu.upc.es")
	by vger.kernel.org with ESMTP id <S135372AbRDZMf7>;
	Thu, 26 Apr 2001 08:35:59 -0400
Message-ID: <3AE81760.3701@mat.upc.es>
Date: Thu, 26 Apr 2001 14:41:04 +0200
From: Francesc Oller <francesc@mat.upc.es>
Reply-To: francesc@mat.upc.es
Organization: UPC
X-Mailer: Mozilla 3.01 (Win95; I)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: a fork-like C-wrapper for clone(), DONE!
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H.P.Anvin wrote:
> >
> > glibc already contains such a wrapper; it is called __clone(). At
> > least my system has "man clone" show the man page for it.
> >
> 
> Actually, the man page is wrong, it's called clone() unless you define
> 
> a function with that name yourself (weak symbol.) My version of the
> man pages are a bit old.
> 
>         -hpa

Unlike mine, neither glibc nor Linus clone.c wrappers are fork-like.
That's why I reworked Linus clone example in the first place

Regards

Francesc Oller

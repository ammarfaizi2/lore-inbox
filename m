Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285046AbRLFIKG>; Thu, 6 Dec 2001 03:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285045AbRLFIKA>; Thu, 6 Dec 2001 03:10:00 -0500
Received: from mail311.mail.bellsouth.net ([205.152.58.171]:40843 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S285049AbRLFIJw>; Thu, 6 Dec 2001 03:09:52 -0500
Message-ID: <3C0F27CA.59C22DEF@mandrakesoft.com>
Date: Thu, 06 Dec 2001 03:09:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.16 for pointers to __devexit functions
In-Reply-To: <11777.1007619756@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch against 2.4.16 defines __devexit_p() for pointers to
> functions defined as __devexit, the wrapper inserts the function name
> or NULL, based on config options.  It allows people to use the new
> binutils on the kernel, there are some real kernel bugs that binutils
> will find once this patch is in.
> 
> I have patched all the obvious references to __devexit functions,
> leaving a few which appear to be real bugs.  I notified the maintainers
> of the buggy code privately.

Why not __attribute__((weak)) ?

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno


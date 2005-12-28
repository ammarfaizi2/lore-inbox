Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbVL1Rnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVL1Rnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 12:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVL1Rnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 12:43:47 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:3747 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932547AbVL1Rnr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 12:43:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qwRiNeNjVnJqiGTLSQ9/hyFA9PbPTlUcdbIpFwZJWvPvpAqj+DBxhnFYu8TVNCfOeKE4T20sWYVVSnB07mTtHQvpbcymwM1pMEJ8AKhXQZ+pmZEhpJsdBV6tW3XJPosor56SXiydNc+wQrohDbfmOKTVgLaqFcKyfJIzc0HjrT4=
Message-ID: <9a8748490512280943u2581f32al11194dd1e51c2401@mail.gmail.com>
Date: Wed, 28 Dec 2005 18:43:45 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Keith Owens <kaos@sgi.com>
Subject: Re: Error patching linux-2.6.9 with kdb-v4.4-2.6.9-i386-1
Cc: Srikanth Srinivasan <ssrikanth1@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <17955.1135784493@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ddce9dad0512272225l5fccba3boe2c0fb7d05f626c8@mail.gmail.com>
	 <17955.1135784493@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/05, Keith Owens <kaos@sgi.com> wrote:
> Srikanth Srinivasan (on Wed, 28 Dec 2005 11:55:12 +0530) wrote:
> >Am relatively new to the linux kernel. I have a problem patching the
> >linux kernel with the kdb kernel debugger.... Here are the steps i
> >followed. Am not sure if i have missed anything... Kindly help me
> >out...
> >
> >1) Untarred the linux-2.6.9 to my home directory
> >[srikanth@zeus linux]$ pwd
> >/home/srikanth/work/src/linux
> >
> >2) Copied kdb-v4.4-2.6.9-i386-1 to /home/srikanth/work/src/linux
> >
> >3) [srikanth@zeus linux]$ patch -p1 < kdb-v4.4-2.6.9-i386-1
> >
> >4) Ran menuconfig and chose  Built-in Kernel Debugger support from
> >Kernel hacking.
> >I alos chose KDB modules to be built.in
> >
> >5) Then when i ran make bzImage i got the error as linux/kdb.h not found
>
> You did not read the README file in ftp://oss.sgi.com/projects/kdb/download/v4.4,
> so you forgot to apply the common kdb patch as well.  The KDB README says -
>
<!-- snip -->

Might also be worth mentioning that 2.6.9 is a bit dated, if one is
just starting out with the kernel one might as well start with a
recent version.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

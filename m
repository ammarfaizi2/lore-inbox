Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWDXHPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWDXHPt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 03:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWDXHPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 03:15:49 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:17515 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751032AbWDXHPs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 03:15:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jza2oMJG63V4C7+UUnYXsGOvv+5+0sRhOxoAto83vhlxcmeKD1xuKhZkm0HjzwUrl4Mh1nqFuPdbvujtxWWh8aNWIRhxlu36KT43wEIwdyIorfgqF79vhA2zNt3aLiTdKRsc894YuetS4Tp1BEe+YLb1MgFAMZBnDkcv7Xjw4zc=
Message-ID: <9a8748490604240015s61b8b897r34a8be65dc9bac22@mail.gmail.com>
Date: Mon, 24 Apr 2006 09:15:47 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] binfmt_elf CodingStyle cleanup and remove some pointless casts
Cc: linux-kernel@vger.kernel.org, ericy@cais.com
In-Reply-To: <20060423142648.6ef34b9f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200604231858.15646.jesper.juhl@gmail.com>
	 <20060423142648.6ef34b9f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/06, Andrew Morton <akpm@osdl.org> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > Here's a patch that does a CodingStyle cleanup of fs/binfmt_elf.c and also
> > removes some pointless casts of kmalloc() return values in the same file.
> >
>
> Much-needed.
>
Nice to know that doing it was worthwhile :)


[snip]
> The typecasting for NEW_AUX_ENT is random, ugly, irrational and
> undesirable.  It's always u32 or unsigned long.  Perhaps as a followup
> patch you could look at removing the unneeded casts? (hopefully that'll
> be all of them)
>
Sure, I'll take a look at that this evening, hopefully that'll mean a
follow-up patch in aproximately 12-16hrs.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

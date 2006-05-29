Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWE2SFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWE2SFa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 14:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWE2SFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 14:05:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:62755 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751148AbWE2SF3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 14:05:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ShyDg6ETr1y8D9fT81s4YptIq7048gHv9/Y6s+minkekbchc2ml8lBhV4MRf8Sw9H6veMAE+J9MEEq+K4k6Y101Acbfa0arKXwNbwTfv8nKaWtqVc9/YowwmKcHcwt9LNsDJMH99kkA0lLDTmN/pZQFRQoGdiMMoRQr+IxgH+F0=
Message-ID: <9a8748490605291105v42e66303pbb45fdccec3a13e4@mail.gmail.com>
Date: Mon, 29 May 2006 20:05:28 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Nick Warne" <nick@linicks.net>
Subject: Re: Question on Space.c
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605291849.04769.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605291849.04769.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/06, Nick Warne <nick@linicks.net> wrote:
> I saw Space.o being build, and seeing as it is Capitalised thought I would see
> why, and maybe a patch to make it all lower case.
>
[snip]
> I have looked though docs and googled as to why this One File Is Like This to
> no avail?  Convention?
>

The normal convention is for filenames to be all lowercase except for
some special ones like "Makefile", "Kconfig", "README" etc (although
there are a few exceptions,for source files, like
drivers/scsi/NCR5380.c, include/asm-m68knommu/MC68328.h,
drivers/block/DAC960.c and others).
To find some more, try this in the kernel source dir : find ./ -name "[A-Z]*"

It would make sense to me personally to rename this one, but it's not
my call and besides it'll open a whole can of worms about whether or
not to rename the other ones...

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

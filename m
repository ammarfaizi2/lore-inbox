Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313467AbSDGURl>; Sun, 7 Apr 2002 16:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313468AbSDGURk>; Sun, 7 Apr 2002 16:17:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31036 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313467AbSDGURi>; Sun, 7 Apr 2002 16:17:38 -0400
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Steven N. Hirsch" <shirsch@adelphia.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Two fixes for 2.4.19-pre5-ac3
In-Reply-To: <20020407173343.GA18940@compsoc.man.ac.uk>
	<E16uIf7-0006Zw-00@the-village.bc.nu>
	<20020407194114.GA21800@compsoc.man.ac.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Apr 2002 14:10:42 -0600
Message-ID: <m1y9fzmfr1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon <movement@marcelothewonderpenguin.com> writes:

> On Sun, Apr 07, 2002 at 08:49:17PM +0100, Alan Cox wrote:
> 
> > Removing it in the -ac tree is a good way to stimulate discussion
> 
> OK
> 
> > fixing the code that relies on it (except for the 99% of code relying on it
> > which is cracker authored trojans)
> 
> No doubt, but it's not much harder to look at nm vmlinux or System.map,
> so I don't see the security angle...
> 
> I'd be happy to bear the brunt of users moaning at me because they now
> have to apply a kernel patch (and I have to maintain it ...), iff there
> was some strongly technical reason the code has to change.

Deep technical reason there are architectures where patching the
system call table does not work.

Eric

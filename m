Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWI0IFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWI0IFI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 04:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWI0IFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 04:05:08 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:25014 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932224AbWI0IFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 04:05:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T18c1WASUgJhXrg10HBdWqUmilwwcBkFd8rSYQMpk1pX8xqs28vZ9Uy02MYdw1850DD8NZ+IFBEucQ77pMbyC3bMbv4+o0/xJU0NDjqJagfTAyVLytXqhB0AcT1UDCRPDCsQTyhhcxG1pgCxuHjSepgYEKkZOwKbNO7WbGMRVlU=
Message-ID: <4d8e3fd30609270105pee59188p8043dda694878e36@mail.gmail.com>
Date: Wed, 27 Sep 2006 10:05:03 +0200
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: x86/x86-64 merge for 2.6.19
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0609261439220.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609261244.43863.ak@suse.de> <200609262202.28846.ak@suse.de>
	 <Pine.LNX.4.64.0609261318240.3952@g5.osdl.org>
	 <200609262226.09418.ak@suse.de>
	 <Pine.LNX.4.64.0609261339050.3952@g5.osdl.org>
	 <4d8e3fd30609261425ob262489nec1240f5a0c5050f@mail.gmail.com>
	 <Pine.LNX.4.64.0609261439220.3952@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/06, Linus Torvalds <torvalds@osdl.org> wrote:
> On Tue, 26 Sep 2006, Paolo Ciarrocchi wrote:
> >
> > out of curiosity, wouldn't be better to sync with Andrew via git?
> > Why via plain patches?
> >
> > What am I missing?
>
> I think you're just missing that we've become so used to it that it's just
> easier than all the alternatives.

Umh.. good point ;)

> Also, the way we do things with Andrew actually has a few advantages over
> a straight git-to-git merge. In particular, when Andrew sends me his
> current stable quilt queue, every email is also Cc'd to the people who
> sent it to him originally or were otherwise involved.

I forgot that Andrew is CC'ing the "author" of the patch when he sends
to you the email.

> So the very act of transferring the patches from one tree to another
> sometimes produces an extra acknowledgement cycle, and we've had patches
> that got NACK'ed at that point because it was an older version of the
> patch etc.
>
> Now, I suspect this is more of an advantage with Andrew's tree than with
> most other trees (most other trees tend to have a much stricter focus),
> and perhaps equally importantly, it also wouldn't really work very well if
> _everybody_ did it, so I personally believe this is one of those
> situations where what's good for _one_ case may not actually be wonderful
> for _all_ cases.
>
> I think it's worked out pretty well, no?

Oh yes! I just did the mistake to think that the work flow of Andrew
was similar to the one used by Andy. And that's clearly a mistake.

Thanks for the clarification.

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com
http://picasaweb.google.com/paolo.ciarrocchi

Return-Path: <linux-kernel-owner+w=401wt.eu-S932169AbXAIPtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbXAIPtJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 10:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbXAIPtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 10:49:09 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:50018 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932167AbXAIPtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 10:49:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jn7Rw6xKctbMbMa3N8wiT1+rbZb/0Ez61yID0p33INo2bCNwmtZmrYV8biFq0haOrYhsre+7UtcYkgV6ukHy6Cs0AAl+oeWzQckg22rjiFc6qnsluVCknoD7UnIySNnSEeAI9fK3Z8owtdnq5AwcgOty6c0q37JbVV7EJZiUCAo=
Message-ID: <9a8748490701090749u3fc503f3vb05a7063bf40c120@mail.gmail.com>
Date: Tue, 9 Jan 2007 16:49:05 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: Akula2 <akula2.shark@gmail.com>
Subject: Re: Jumping into Kernel development: About -rc kernels...
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8355959a0701090733l74d03792q16b3022d949c7ae1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8355959a0701090733l74d03792q16b3022d949c7ae1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/07, Akula2 <akula2.shark@gmail.com> wrote:
> Hello All,
>
> This question might sound dumb for many, and to some annoying too ;-)
>
> Am enterting into -rc Kernel (testing & analysis) & involvement with
> the kernel (contributing to patches). I have this doubt. I did refer
> to applying-patches in the kernel documentation, this is what I got:-
>
> > These are the base stable releases released by Linus. The highest numbered
> > release is the most recent.
>
> > If regressions or other serious flaws are found, then a -stable fix patch
> > will be released (see below) on top of this base. Once a new 2.6.x base
> > kernel is released, a patch is made available that is a delta between the
> > previous 2.6.x kernel and the new one.
>
> > To apply a patch moving from 2.6.11 to 2.6.12, you'd do the following (note
> > that such patches do *NOT* apply on top of 2.6.x.y kernels but on top of the
> > base 2.6.x kernel -- if you need to move from 2.6.x.y to 2.6.x+1 you need to
> > first revert the 2.6.x.y patch).
>
> I did understand till here. Should I start compile/test/debug
> one-after-one in this fashion:-
>
> 2.6.19 source + patch-2.6.20-rc1
> 2.6.19 source + patch-2.6.20-rc2
> 2.6.19 source + patch-2.6.20-rc3
> 2.6.19 source + patch-2.6.20-rc4
>
> OR
>
> Pick the latest release number?
>

Depends on what you want to do.  If you want a stable kernel to use in
production you should probably pick the latest stable kernel
(currently that's 2.6.19.1).
If you want to help fix bugs, develop features, test etc, then it is
usually best to use the latest development snapshot available.  An
easy way to always have the tip of the tree available is to use git -
see this document for more info : http://linux.yyz.us/git-howto.html

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

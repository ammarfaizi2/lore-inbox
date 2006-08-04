Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWHDKn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWHDKn6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 06:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWHDKn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 06:43:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:45179 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751380AbWHDKn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 06:43:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TE8tMUKj1+8qOQCHAIljcyE9KSh6zVj1z4GjT5Yebaz+GnnXCCaFsYl5RkgwsImviq9sDtbL1sVYESY+XHQXCX/xI+RNrMdjH6Ko1Hrs4VFpiuRLlZ1hWUwtbkPuaaake+uV3C+BNHiPBiZgSR6BYwXAKeW4WmoEjhabADF/ZPU=
Message-ID: <9a8748490608040343p472591b8n9856f4afd78c9dfa@mail.gmail.com>
Date: Fri, 4 Aug 2006 12:43:54 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
In-Reply-To: <20060804200549.A2414667@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490608040122l69ff139dtaae27e8981022dae@mail.gmail.com>
	 <20060804200549.A2414667@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/06, Nathan Scott <nathans@sgi.com> wrote:
> On Fri, Aug 04, 2006 at 10:22:21AM +0200, Jesper Juhl wrote:
> > I just hit a BUG that looks XFS related.
> >
> > The machine is running 2.6.18-rc3-git3
> >
> > (more info below the BUG messages)
> >
>
> Thanks for reporting, Jesper - is it reproducible?

I don't know. I only tried that kernel once and when it broke on me
went back to the previous 2.6.11 kernel it was running before.


>  Could you try this
> patch for me?

Sure.
The machine is semi-production, so there are limits to how much and
when I can test on it.
roughly wednesday and thursday each week I should be able to run
experimental kernels on it, the rest of the week the box needs to be
stable.

>  We had a couple of other reports of this, but the earlier
> reporters have vanished ... could you let me know if this helps?
>

What I'll do is apply that patch to the 2.6.18-rc3-git3 kernel that
BUG'ed on me, then wednesday next week I'll boot the machine with the
patched kernel and it should be able to run for ~24hrs, then I can
report back to you if it crashed or not.

Or is there some other way you'd rather have me do it (subject to the
constraint that I can only do experiments one and a half to two days a
week) ?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbVLaLtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVLaLtY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 06:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVLaLtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 06:49:24 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:23351 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932158AbVLaLtX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 06:49:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mQLjnOL9P+zbxPtAxy0xsMO6p/uf2OZjgP59YKWZ5f5lRvuo4vS7W1bVTO3FidGjnyGfDrgFs3kEmaag4lFAB17hWAGRuC8BH3HU0L3VJv8Tncki1kEbMZ2zaysHV2e8ymCOvKBzat5z0B+yebuPJJ009n56cu3nc5astqzUlO0=
Message-ID: <9a8748490512310349g10d004c7i856cf3e70be5974@mail.gmail.com>
Date: Sat, 31 Dec 2005 12:49:22 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Mark v Wolher <trilight@ns666.com>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Lee Revell <rlrevell@joe-job.com>,
       Folkert van Heusden <folkert@vanheusden.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43B66E3D.2010900@ns666.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43B53EAB.3070800@ns666.com>
	 <200512310027.47757.s0348365@sms.ed.ac.uk>
	 <43B5D3ED.3080504@ns666.com>
	 <200512310051.03603.s0348365@sms.ed.ac.uk>
	 <43B5D6D0.9050601@ns666.com> <43B65DEE.906@ns666.com>
	 <9a8748490512310308g1f529495ic7eab4bd3efec9e4@mail.gmail.com>
	 <43B66E3D.2010900@ns666.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/05, Mark v Wolher <trilight@ns666.com> wrote:
> Jesper Juhl wrote:
> > On 12/31/05, Mark v Wolher <trilight@ns666.com> wrote:
> >
> >>g'morning !
> >>
> >>the memtest86 went 40 times over the memory, no errors detected.
> >>
> >
> > Give memtest86+ a spin (http://www.memtest.org/) as well. memtest86 is
> > good, but I've found in the past that memtest86+ sometimes finds
> > errors that memtest86 does not, so giving both a sin fo an extended
> > period of time is usually a good idea.
> > Also, make sure you enable all the tests of both tools.
>
> Hi Jesper,
>
> Oh i thought they were the same, i used memtest86+ which comes with
> debian and not the "older" memtest86.
>
> Right now i booted the kernel with nomce since one never knows with dell

Surpressing MCE's (Machine Check Exceptions) is a really bad idea
usually. MCE's indicate a hardware problem, so unless it's known that
a certain MCE is reported wrongly they should *not* be ignored.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

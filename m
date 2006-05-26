Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWEZWLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWEZWLW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 18:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWEZWLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 18:11:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:16213 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750707AbWEZWLV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 18:11:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fCPKufGiNzKIAThY8HPe7ozbhBHei10wBIqD4zS1bI7fpieSpVP1meBsEcgVu/XyvretBsgcaeuWiA22VUgY1XtpiYnVhrx0eib9uNyUlxdpH/D4OWGkZQ7AeltuZu7OrqcpuawDZU1nal1OW3lpP4oZbxZgTLYv92HJ6cI1I7k=
Message-ID: <5bdc1c8b0605261511u1d4c224rb766638de367e2c@mail.gmail.com>
Date: Fri, 26 May 2006 15:11:20 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: "K.R. Foley" <kr@cybsft.com>
Subject: Re: 2.6.16-rt24 Won't Apply
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Steven Rostedt" <rostedt@goodmis.org>
In-Reply-To: <44775F43.8020500@cybsft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <44775129.6030004@cybsft.com> <20060526194315.GA860@elte.hu>
	 <44775F43.8020500@cybsft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/06, K.R. Foley <kr@cybsft.com> wrote:
> Ingo Molnar wrote:
> > * K.R. Foley <kr@cybsft.com> wrote:
> >
> >> Ingo,
> >>
> >> The 2.6.16-rt24 patch that you uploaded today will not apply cleanly
> >> to a 2.6.16 source tree. Below is the first of many problems, if this
> >> helps.
> >
> > could you try -rt25, does it work any better?
> >
> >       Ingo
>
> Yes. It applies cleanly. Will know soon if it builds and boots.
>
> --
>    kr
>

Ingo & (I think) Steven,
   -rt25 applies cleanly and boots fine on my AMD64 UMP machine.

mark@lightning ~ $ uname -a
Linux lightning 2.6.16-rt25 #1 PREEMPT Fri May 26 14:53:47 PDT 2006
x86_64 AMD Athlon(tm) 64 Processor 3000+ GNU/Linux
mark@lightning ~ $

   Thanks to all for putting this fix together. I'm sorry I didn't do
much with the 2.6.16-rt series. I was so happy with 2.6.15-rt18 I
never moved forward. I promise to take a lot at 2.6.17 when that comes
along.

Cheers,
Mark

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWETSfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWETSfp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 14:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWETSfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 14:35:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:3861 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932354AbWETSfp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 14:35:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HDpNGfg68Qz/JiIulYgW3n8IgDk0iD7URXTZaJLPJuERSH3KBPwhiwk08h4bGrb08b7f1mx6tuYKDXkRkPWX3cqVIHHM33h7jlEmlXNY6BfTmXXhUywwdOSbpoJH4AKBtzlYcyxm+PAQTAHi+K1G1mWZ2gmLwmTiMNtXDiz5KaE=
Message-ID: <69304d110605201135v780ebf66p7c86269c07a9983@mail.gmail.com>
Date: Sat, 20 May 2006 20:35:42 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Joel Jaeggli" <joelja@uoregon.edu>
Subject: Re: Stealing ur megahurts (no, really)
Cc: "Matti Aarnio" <matti.aarnio@zmailer.org>,
       "John Richard Moser" <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <446DE6E9.9080707@uoregon.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <446D61EE.4010900@comcast.net>
	 <20060519101006.GL8304@mea-ext.zmailer.org>
	 <446DE6E9.9080707@uoregon.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/06, Joel Jaeggli <joelja@uoregon.edu> wrote:
> Matti Aarnio wrote:
> > On Fri, May 19, 2006 at 02:13:02AM -0400, John Richard Moser wrote:
> > ...
> >> On Linux we have mem= to toy with memory, which I personally HAVE used
> >> to evaluate how various distributions and releases of GNOME operate
> >> under memory pressure.  This is a lot more convenient than pulling chips
> >> and trying to find the right combination.  This option was, apparently,
> >> designed for situations where actual system memory capacity is
> >> mis-detected (mandrake 7.2 and its insistence that a 256M memory stick
> >> is 255M....); but is very useful in this application too.
> >>
> >> This brings the idea of a cpumhz= parameter to adjust CPU clock rate.
> >> Obviously we can't do this directly, as convenient as this would be; but
> >> the idea warrants some thought, and some thought I gave it.  What I came
> >> up with was simple:  Adjust time slice length and place a delay between
> >> time slices so they're evenly spaced.
> > ...
> >> Questions?  Comments?  Particular ideas on what would happen?
>
> The other thing  I would observe is that clock speed is only part of the
> equation, it's one thing to soak up some cpu cycles, but the cpu may be
> a lot more superscalar (pipelineing, simd instructions, multiple cores
> etc) than the one you're trying to simulate, probably it also has a lot
> more cache and much faster memory. So that while you can certainly soak
> up a lot of cpu pretty easily there are other considerations that might
> effect simulating the performance of say a 100mhz pentium on say an
> athlon 64x2.
>
> emulation would probably go a lot further as an approach
>
> > Modern machines have ability to be "speed controlled" - Perhaps
> > they can cut their speed by 1/3 or 1/2, but run slower anyway
> > in the name of energy conservation.
> >
> >
> > Another approach (not thinking on multiprocessor systems now)
> > is to somehow gobble up system performance into some "hoarder"
> > (highest scheduling priority, eats up 90% of time slices doing
> > excellent waste of CPU resources..)
> >
>
> <snip>
>

what is really needed is to be able to throttle the memory latency and
bandwith.. even with +++Ghz processors if there is no memory speed all
the rest lacks... this would enable better testing of memory intensive
algorithms


-- 
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.

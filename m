Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263659AbTJCEHm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 00:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbTJCEHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 00:07:42 -0400
Received: from [63.161.72.3] ([63.161.72.3]:37782 "HELO
	mail.standardbeverage.com") by vger.kernel.org with SMTP
	id S263659AbTJCEHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 00:07:41 -0400
Message-ID: <ddcbaa61f5ab6ec90c71a70bb3990b49@stdbev.com>
Date: Thu,  2 Oct 2003 22:51:21 -0500
From: "Jason Munro" <jason@stdbev.com>
Subject: Re: Linux 2.6.0-test6
To: linux-kernel@vger.kernel.org
Reply-to: <jason@stdbev.com>
In-Reply-To: &lt;3F7CBDD4.7010503@cyberone.com.au&gt;
References: &lt;Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org&gt;
            &lt;200309281703.53067.kernel@kolivas.org&gt;
            &lt;200309280502.36177.rob@landley.net&gt;
            &lt;3F77BB2C.7030402@cyberone.com.au&gt;
            &lt;3F7863F0.6070401@wmich.edu&gt;
            &lt;20031002004102.GB2013@81.38.200.176&gt;
            &lt;3F7B9600.408@cyberone.com.au&gt;
            &lt;20031002190744.GC1215@81.38.200.176&gt;
            &lt;3F7CBDD4.7010503@cyberone.com.au&gt;
X-Mailer: Hastymail 0.7-CVS
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 2, 7:07 pm Nick Piggin <piggin@cyberone.com.au> wrote:
>
> Pedro Larroy wrote:
>
> > On Thu, Oct 02, 2003 at 01:05:36PM +1000, Nick Piggin wrote:
> > I'm afraid this selection criteria leads to a scheduler that isn't
> > predictable for situations that aren't the ones for which is tuned to
> > work. Of course I may be wrong, but to me, seems that saying
> > explicitly which tasks are interactive sounds better.
> >
>
> Have a look at my scheduler if you like. It won't estimate interactivity
> but it works quite well if you nice -10 your X server. Ie. explicitly
> state which process should be favoured.
> http://www.kerneltrap.org/~npiggin/v15a/

I don't know much about kernel internals but of the 2.5 and 2.6 kernels I
have tried, 2.6.0-test6 is by far the best on the desktop for my use (xmms,
vmware, firebird, loads of other apps). With this patch it's better still.
Before patching simple things like ls or ps have an annoying slowness while
under a moderate/heavy load. For the most part things are fine but after
patching commands respond more quickly. This is the first time for me a
2.5+ kernel has been responsive enough to use on a daily basis.

Thanks everyone for the great work!

\_____ Jason Munro ________________________
 \_____ jason@stdbev.com ___________________
  \_____ #hastymail at irc.freenode.net _____
   \_____ http://hastymail.sourceforge.net ___

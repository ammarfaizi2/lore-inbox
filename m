Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTFKVLn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTFKVLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:11:30 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:47518
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S264491AbTFKVLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:11:21 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Eli Carter <eli.carter@inet.com>
Subject: Re: [PATCH] Documentation/SendingPatches [2 of 2].
Date: Wed, 11 Jun 2003 17:27:31 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200306111618.10329.rob@landley.net> <3EE793DD.7080408@inet.com>
In-Reply-To: <3EE793DD.7080408@inet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306111727.31651.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 June 2003 16:41, Eli Carter wrote:
> Rob Landley wrote:
> > The bit about log rolling.
> >
> > --- linux-new/Documentation/SubmittingPatches	2003-06-11
> > 15:54:29.000000000 -0400 +++
> > linux-new/Documentation/SubmittingPatches2	2003-06-11 15:54:06.000000000
> > -0400 @@ -92,6 +92,16 @@
> >  complete, that is OK.  Simply note "this patch depends on patch X"
> >  in your patch description.
> >
> > +In politics, there's a concept called "log rolling", where unrelated
> > +amendments are bundled together so that changes people want grease the
> > +way for changes they don't.  Do not do this.  It's annoying.
> > +
> > +In coding, this sort of thing can be very subtle, such as performance
> > increases +that help your new version perform as well as the original
> > while doing more +work, but which could also have been applied to the
> > original making it even +faster.  The linux-kernel guys are very good at
> > taking the chocolate coating +and leaving the pill behind.  This can be
> > very frustrating to developers, but +it's one of the big reasons open
> > source produces such excellent results.
>
> They are also likely to tell _you_ to take the pill out, clean up the
> chocolate, and resubmit; and that takes more of _your_ time.

Oh sure. :)

I pondered adding various comments along the lines of "Don't insult the 
intelligence of the people you're sending it to by assuming they can't break 
it out for themselves.  Do assume they're lazy enough to tell YOU to do it, 
and reject the whole patch until then.  Ask yourself: would you rather get 
some of your code into the kernel, or none at all?"

And also a longer admonition, that getting mad about this sort of thing is a 
very common problem among newbies, and you just have to grow up and learn to 
leave all-or-nothing behind and live with shades of grey to function around 
here in the long term.

But I was trying very hard to keep it short.  Feel free to amend the patch if 
you can think of anything better to say. :)

I was also trying not to wander off topic.  There are all sorts of related 
areas like "gradual transition" vs "flag day" approaches to large patches.  
For now, if they're doing a large enough patch we can assume they've been 
enculturated.  (Well, mostly.)  In the long term, "theory of linux-kernel 
development" might not belong belong in SubmittingPatches.  Maybe a seperate 
document, or in a FAQ somewhere, or the README...  Dunno.

> (And I do like that you broke the log rolling change out; very good
> object lesson. :) )
>
> Eli

Thanks.  It seemed the thing to do. :)

Rob

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284812AbRLXMhs>; Mon, 24 Dec 2001 07:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284813AbRLXMhi>; Mon, 24 Dec 2001 07:37:38 -0500
Received: from t2.redhat.com ([199.183.24.243]:19186 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S284812AbRLXMhX>; Mon, 24 Dec 2001 07:37:23 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <4.3.2.7.2.20011223080930.00c5aed0@10.1.1.42> 
In-Reply-To: <4.3.2.7.2.20011223080930.00c5aed0@10.1.1.42>  <4.3.2.7.2.20011222075342.00c11e00@10.1.1.42> <4.3.2.7.2.20011222075342.00c11e00@10.1.1.42> <Pine.GSO.4.30.0112221113120.2091-100000@balu> <E16H9C4-0005ST-00@sites.inka.de> <Pine.GSO.4.30.0112221113120.2091-100000@balu> 
To: Stephen Satchell <list@fluent2.pyramid.net>
Cc: Phil Howard <phil-linux-kernel@ipal.net>, linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 24 Dec 2001 12:37:17 +0000
Message-ID: <26276.1009197437@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


list@fluent2.pyramid.net said:
> >If you are more interested in the choices of the marketplace than in
> >technical correctness, one has to wonder what you're doing on this mailing
> >list.

> Nice ad hominem attack, David.  Attack the messenger.  Good boy.

That's not what I understood 'ad hominem' to mean. My understanding was that
ad hominem involved an attack on the person making the argument, followed by
an obviously false assertion that such attack renders the person's arguments
invalid, even though the details of the attack made are completely unrelated
to the matter being discussed.

Thus observing that you sent your mail using a Windows MUA, then declaring
that your argument is invalid because you're a Windows user and therefore 
obviously mentally deficient, would be an ad hominem attack.

My response, though it could possibly be called an 'attack' if you were
feeling particularly thin-skinned, was definitely based upon the discussion
at hand - I expressed surprise at the criterion of marketplace acceptability
which you used to justify your position.

>  I also mentioned that we have a very, very large base of "legacy
> users" who  do not understand what MiB would be (outside of the
> context of the movie  _Men in Black_) and who would become very, very
> confused.  In short, making  the change would CONFUSE THE
> NON-TECHNICAL USERS more than they already are. 

But this term _is_ used outside that context. And the context it's used in,
in just about all cases, makes it blindingly obvious to all but the densest
reader what the intended meaning is. Maybe _those_ people will remain
slightly confused about where we mean 10^3 and where we mean 2^10, but at
least people with a clue no longer have to be confused about such things.

As an example - what possible meaning could you contrive for 'KiB' in the
following:

  This lets you select the page size of the kernel.  For best IA-64
  performance, a page size of 8KiB or 16KiB is recommended.  For best
  IA-32 compatibility, a page size of 4KiB should be selected (the vast
  majority of IA-32 binaries work perfectly fine with a larger page
  size).  For Itanium systems, do NOT chose a page size larger than
  16KiB.

Surely it's difficult to imagine anyone reading that and coming to any 
other conclusion than the correct one?


I accept that is often appropriate to 'dumb down' documentation and
explanations somewhat to cater for the lowest common denominator members of 
the audience. 

It is much more rarely appropriate to dumb it down so far that it becomes
factually inaccurate. The tuition of physics at high school, in Further
Education and then Higher Education is perhaps an example of when such
oversimplifications are necessary and appropriate. Some people will never
need to know that Newton's Laws break down, and even if that weren't the
case, they wouldn't have a whelk's chance in a supernova of understanding
Relativity anyway. So why trouble them with it?

But in the situation at hand, there is no justification for catering to the
ignorant in our documentation to the extent that it becomes inaccurate. The
difficulty in understanding the correct text is just not sufficient to
justify the inaccuracies.

--
dwmw2



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQJ3QqD>; Mon, 30 Oct 2000 11:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129298AbQJ3Qpx>; Mon, 30 Oct 2000 11:45:53 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:52996 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129045AbQJ3Qph> convert rfc822-to-8bit; Mon, 30 Oct 2000 11:45:37 -0500
Date: Mon, 30 Oct 2000 16:45:17 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Mark Spencer <markster@linux-support.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.0-test9 not Open Source
In-Reply-To: <Pine.LNX.4.21.0010281049300.26640-100000@hoochie.linux-support.net>
Message-ID: <Pine.LNX.4.21.0010301525200.14004-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2000, Mark Spencer wrote:

> Now firstly, let's eliminate the ISDN red-herring from consideration
> because the authors of the code do not place any additional restrictions
> on the GPL whatsoever, they simply bring it to your attention that using
> an un-certified ISDN stack may be illegal in some countries.

I am the author of the code in question. I have placed it under GPL. I do
not place any additional restrictions on the GPL whatsoever, I simply
bring it to your attention that using it on some hardware may be illegal
in some countries.

Besides, you misquoted. What the GPL in fact says is:
	"You may not impose any further restrictions on the recipients' 
	exercise of the rights granted herein."

So in order for it to be a problem:
	1. _I_ must impose the restriction. Not your local laws.
	2. The right in question (in this case, the right to use the 
		NFTL code) must be 'granted [t]herein'. 


So the NFTL is fine on both counts, then, because:
	1. I don't.
	2. It isn't (see below...)

Reading on will explain my answer to #2...
	"Activities other than copying, distribution and modification are
	not covered by this License; they are outside its scope."

That's good. Not only is the right to use not explicitly granted therein,
but the GPL is fairly explicit about the fact that it's not relevant.

Immediately after that quote, it does say:
	"The act of running the Program is not restricted, ..."

Note the wording "is not", not "must not be" - it is saying that the GPL
does not of itself place restrictions on the act of running the program -
which serves to verify what it said above, about being _only_ to do with
"copying, distribution and modification".



> Richard believes that this violates the GPL because it places additional
> restrictions not found in the GPL.

I have discussed this with Richard before. I disagree, for the reasons
stated above:
	1. The licence does _not_ restrict the use of the code. Your
		local laws do. This is _precisely_ the same as the 
		ISDN situation.
Also	2. The right to use isn't 'granted [t]herein' anyway.

The last conversation I had with Richard on this topic, IIRC, ended in him
all but admitting that the GPL doesn't in fact prevent this. Of course he
didn't actually _say_ that, but he did fall back to claiming that it was
his _intention_ that was legally binding, not the text of the licence.

AFAIK his statement is incorrect, except where the actual text of the
licence is ambiguous. I see no ambiguity in the sentence "Activities other
than copying, distribution and modification are not covered by this
License; they are outside its scope."

> In any case, it seems pretty obvious that this restriction violates
> section 6 of the Open Source Definition which states:

Irrelevant. I neither know nor care in this context whether it meets this
Open Source Definition of which you speek. I care whether it can be merged
with Linux, which is under the GPL - and IMO it can. As Linus accepted the
code after I notified him of the situation, I infer that he shares my
opinion. Note that even in the case of an ambiguity in the text of the
GPL, I believe in this case that it it Linus' intention, not RMS', which
would be relevant.

Go persuade the Debian folks to stop distributing the Linux kernel because
my code doesn't meet the OSD, and get back to me when they've taken you
seriously. While you're at it, note that the sendfile() code is covered by
patents too. ISTR there are other instances as well.

Don't get me wrong - I detest the practice of patenting software, but I
don't believe that the existence of a patent should prevent us from using
the algorithm either
	1. Where it is legal to do so - which is either in the Free
		World where the insane patent doesn't apply, or on 
		DiskOnChip hardware, for which M-Systems have granted
		permission.
or 	2. Even where it is not legal, if someone wishes to challenge 
		the patent or 'call the bluff' of the patent-holder.


>   "The license must not restrict anyone from making use of the program in
> a specific field of endeavor...."

Oh, that's good. It's not the licence which makes the restriction, it's
some entirely separate local legislation, just like in the ISDN case. So
it looks like the code _does_ meet the OSD. As I said, take it up with the
Debian people. Until they threaten to remove the Linux kernel, I don't
want to know.

> In this case, the field of endeavor is to use it with another vendor's
> product.

I know of nobody else who wants to do so, rendering the whole exercise a
rather pedantic Gedankenexperiment. Emulating a block device using a kind
of journalling pseudo-filesystem, and then having to put a 'normal'
journalling filesystem on top of that, is just insane. Except where it's
the status quo, nobody would want to use it - using a JFFS filesystem
directly on the flash is far more appropriate.¹

Besides, if you want to do so, then my code has given you the _freedom_ to
use it and challenge the patent which IMO should not have been granted in
the first place. There's nothing in my code or its licence which prevents
you from doing just that.

> Comments welcome and appreciated.

Please don't take my tone the wrong way - it's just that I've had this
discussion too many times before.

--
dwmw2

¹ We'll have JFFS working on NAND flash RealSoonNow(tm). 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

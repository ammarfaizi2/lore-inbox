Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277702AbRJVTPj>; Mon, 22 Oct 2001 15:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277686AbRJVTPZ>; Mon, 22 Oct 2001 15:15:25 -0400
Received: from frood.pikka.net ([64.81.49.24]:53689 "HELO frood.pikka.net")
	by vger.kernel.org with SMTP id <S277713AbRJVTPJ>;
	Mon, 22 Oct 2001 15:15:09 -0400
Date: Mon, 22 Oct 2001 12:14:47 -0700
From: Tudor Bosman <tudorb@pikka.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.20pre10
Message-ID: <20011022121447.A5618@frood.pikka.net>
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <86256AED.0065BD5D.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86256AED.0065BD5D.00@smtpnotes.altec.com>
User-Agent: Mutt/1.3.21i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, let's get the disclaimer out of the way.  This post is opinionated,
and IANAL.  Now...


For reference, here is the full text of the DMCA subsection in question:
(1201(2)):

 ``(2) No person shall manufacture, import, offer to the public,
provide, or otherwise traffic in any technology, product, service,
device, component, or part thereof, that-

          ``(A) is primarily designed or produced for the purpose
    of circumventing a technological measure that effectively con-
    trols access to a work protected under this title;
          ``(B) has only limited commercially significant purpose or
    use other than to circumvent a technological measure that
    effectively controls access to a work protected under this title;
    or
          ``(C) is marketed by that person or another acting in concert
    with that person with that person's knowledge for use in cir-
    cumventing a technological measure that effectively controls
    access to a work protected under this title.


I would like to comment on this from two different angles.

1. The subsection mentions "any technology, product, service, device,
component, or part thereof".  While this definition is vague, and we
hackers tend to like splitting hairs (see Dave Touretzky's DeCSS
gallery, http://www-2.cs.cmu.edu/~dst/DeCSS/Gallery/index.html), there
is a clear distinction between (constitutionally-protected) speech (in a
non-machine readable) form, and a software product.  Other forms of
expression (source code, non-machine readable source code, source code
set to music, etc.) lie on the fine line between the two.

For example, exporting PGP on paper and OCR-ing it (because exporting it
in electronic form was illegal) was a legal absurdity.  While this 
hair-splitting might have amused a few lawyers and judges here and
there, I believe that a well-versed attorney could have torn that
defense to pieces, because we tried drawing demarcation lines instead of
concentrating on defeating the spirit of the law.

The above-mentioned paragraphs make no reference to "information" or a
"description" of such a circumvention device.  A high-level description
(in plain English) of a security hole is not a "technology, product,
service, device, component, or part thereof"; and if it can be construed
as such, surely the realization of such description (the source code
itself) is much closer to the notion of a "product".  Is this the end of
full disclosure and open source/free software?  Should BUGTRAQ be banned
from US residents?


2. The arguments for/against publishing the description of the security
hole in the DMCA context are the same as the arguments for/against full
disclosure in the security field in general.  IF the description were
published, then... (paraphrasing the three DMCA paragraphs I cited)

(A) it would NOT be primarily designed for circumventing a technological
measure that effectively controls access to a protected work- it would
be primarily designed for informing system administrators of their risks
and the importance of the patch, and informing developers of pitfalls to
avoid in writing new code;

(B) it would have a LARGE commercially significant purpose other than to
circumvent a technological measure that effectively controls access to a
protected work- the main purpose would be to urge system administrators
and developers to implement a higher degree of protection (at the very
least, apply the patch), and

(C) it would NOT be marketed by Alan Cox or another acting in concert
with him for use in circumventing a technological measure that
effectively controls access to a protected work- this is a no-brainer, I
don't think there are many people on this list who openly advocate
exploiting security holes for gaining unauthorized access.


In conclusion, I tried to make two points in the above rant:

1. A description of a security hole is constitutionally protected
speech, and as such cannot be construed as violating the sections of the
DMCA.  If such description fits the definition of "technology, product,
service, device, component, or part thereof", then we're in big trouble,
because source code itself is much closer to the definition of a
"product" than a description of the source code.

2. A description of a security hole, or unpatched source code, or even
exploit code do not meet the criteria set forward by the DMCA for
illegal circumvention devices.


Best regards,

Tudor.


-- 
"They that can give up essential liberty to obtain a little temporary
 safety deserve neither liberty nor safety."
        - Benjamin Franklin, Historical Review of Pennsylvania, 1759.

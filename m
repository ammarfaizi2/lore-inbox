Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131139AbRA2Scw>; Mon, 29 Jan 2001 13:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132119AbRA2Scm>; Mon, 29 Jan 2001 13:32:42 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:48134 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S131139AbRA2Sc0>;
	Mon, 29 Jan 2001 13:32:26 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101291831.f0TIV7h484162@saturn.cs.uml.edu>
Subject: Re: ECN: Clearing the air (fwd)
To: davem@redhat.com (David S. Miller)
Date: Mon, 29 Jan 2001 13:31:07 -0500 (EST)
Cc: jas88@cam.ac.uk (James Sutherland),
        miquels@traveler.cistron-office.nl (Miquel van Smoorenburg),
        linux-kernel@vger.kernel.org
In-Reply-To: <14965.7321.926528.391631@pizda.ninka.net> from "David S. Miller" at Jan 28, 2001 11:32:41 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
> James Sutherland writes:

>> Except you can detect and deal with these "PMTU black holes". Just as you
>> should detect and deal with ECN black holes. Maybe an ideal Internet
>> wouldn't have them, but this one does. If you can find an ideal Internet,
>> go code for it: until then, stick with the real one. It's all we've got.
>
> Guess what, Linux works not around PMTU black holes either for the
> same exact reason we will not work around ECN.
>
> I'm getting a bit tired of you, and I suppose others are as
> well.  You are being nothing but a pompous ass.

He is being practical. You are being idealistic.

> Anyways, let me quote a comment from the Linux source code where
> we would have done PMTU black hole detection:
> 
> /* NOTE. draft-ietf-tcpimpl-pmtud-01.txt requires pmtu black
>   hole detection. :-(
>   It is place to make it. It is not made. I do not want

So the Linux code is broken. ("requires")

>    to make it. It is disguisting. It does not work in any
>    case. Let me to cite the same draft, which requires for
>    us to implement this:
...
>    upper-layer protocols.  The safest web site in the world is worthless
>    if most TCP implementations cannot transfer data from it.  It would
>    be far nicer to have all of the black holes fixed rather than fixing
>    all of the TCP implementations."

The author is expressing his wish for an ideal world. Note that he
also accepts reality. He accepts that PMTU black holes won't go
away, even though we might like them to do so.

Hell, I think I'm behind one. ICMP is/was blocked to/from/within
the entire university. This was to stop ping flood attacks. :-)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

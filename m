Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269790AbUJAN5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269790AbUJAN5B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 09:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269793AbUJAN5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 09:57:00 -0400
Received: from ruis.pair.com ([209.68.1.63]:19975 "helo ruis.pair.com")
	by vger.kernel.org with SMTP id S269790AbUJANyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 09:54:05 -0400
Message-Id: <200409291344.i8TDiMv11397@blake.inputplus.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Possible GPL Violation of Linux in Amstrad's E3 Videophone.
Date: Wed, 29 Sep 2004 14:44:22 +0100
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Note, suspect this didn't appear earlier because of vger disliking
mention of De*tschland!]

Hi,

I've been talking with UK company Amstrad PLC regarding their
obligations under the GNU GPL for the Linux they ship on their new E3
videophone in the UK.

    http://www.amstrad.com/default.shtml
    http://www.amstrad.com/e3_intro.html

It's based on a TI OMAP ARM SoC and runs MontaVista Linux.

    http://www.linuxdevices.com/news/NS6619549199.html
    http://www.amstrad.com/news_linux.html
    http://www.mvista.com/news/2004/amstrad.html

They're shipping the E3 in a box for sale off the shelf in places like
Dixons, Currys, etc.  I believe they haven't complied with section 3 of
the GNU GPL.  There's no source shipped in the box, i.e. 3(a).  There's
no written notice either, 3(b), in the thick manual, or the other sheets
of paper in the box, printed on the box, or on stickers on the E3.  I
inspected the contents of a box, serial number available if required, at
my local store with the agreement of a staff member who opened all the
wrappings.  The manual had "Issue No. 9 (D1/H4)" printed at the bottom
right corner of page 1, as does the online PDF of the manual available
for download.

    ftp://ftp.amstrad.co.uk/e3_userguide_web_v1.zip   9,614,278 bytes

I am not an E3 owner, nor have I been passed the GPL'd binaries with or
without a written offer under 3(c).

Initially I tried discussing their compliance with
support@amserve.ltd.uk but they were only willing to discuss source
access details on presentation of proof of purchase, e.g. serial number,
registered phone number, etc., and weren't willing to discuss if they
were complying with the GPL.

So I next emailed Sir Alan Sugar, Amstrad Chairman, and got a reply from
Brian Eaton, E-Business Director.  He initially, like Support, seemed
confident they were complying but I got the impression he hadn't
actually read my argument so I tried once more to point out how what
they were doing wasn't complying.  This time I got a reply saying

    "Your comments are noted. We will get back to you shortly. In the
    meantime can you let me have your postal address please so that I
    can send you something?"

This, coupled with activity to my Amstrad Linux page from several
browsers at an IP address similar to Amstrad's public ones around the
time Brian's reply was sent, makes me think I should make the issue
public before anything that would prevent me doing that may happen.

All my correspondence is attached but the most interesting is message 9
where I spell out the license requirements to Brian Eaton, 10 where he
yesterday asked for my address, and 11 where he re-stated they've don't
have to discuss it with me.  I think they're failing to comply with
section 3.  There's other minor things too in the manual that I've
highlighted.  They're right in saying they've no obligation to discuss
their compliance with me.  I'm hoping that by posting here a copyright
holder will query their apparent lack of compliance and Amstrad will be
happy to converse with them.

To re-iterate, there's no source code or written offer in the box.  They
say they'll provide a URL to an E3 owner on proof of ownership but
that's insufficient.  The situation is made more complex by the E3
downloading software updates, including seemingly the kernel, so they'll
be multiple versions to provide source for over time.

Cheers,


Ralph.


------- Forwarded Messages

Return-Path: ralph@inputplus.co.uk
Delivery-Date: Thu Sep 23 23:57:40 2004
Return-Path: <ralph@inputplus.co.uk>
Received: from blake.inputplus.co.uk (ralph@localhost)
	by blake.inputplus.co.uk (8.11.6/8.11.6) with ESMTP id i8NMvdI03159;
	Thu, 23 Sep 2004 23:57:40 +0100
Message-Id: <200409232257.i8NMvdI03159@blake.inputplus.co.uk>
To: support@amserve.ltd.uk
Subject: Source for E3's MontaVista Linux.
Date: Thu, 23 Sep 2004 23:57:39 +0100
From: Ralph Corderoy <ralph@inputplus.co.uk>


Hi,

I see from the joint MontaVista/Amstrad press release that MontaVista
Linux has been chosen for the E3's operating system.  I've had a hunt
around the amstrad.co.uk web site and haven't been able to find a
download of the source for the binaries shipped on the E3 that are
covered by the GNU General Public License.

Could you please let me know how to obtain them.

Many thanks,


Ralph.

------- Message 2

Return-Path: support@amserve.ltd.uk
Delivery-Date: Fri Sep 24 14:13:40 2004
Return-Path: <support@amserve.ltd.uk>
Received: from localhost (localhost [127.0.0.1])
	by blake.inputplus.co.uk (8.11.6/8.11.6) with ESMTP id i8ODDeu07998
	for <ralph@localhost>; Fri, 24 Sep 2004 14:13:40 +0100
Delivered-To: inputplu-inputplus:co:uk-ralph@inputplus.co.uk
X-Envelope-To: ralph@inputplus.co.uk
Received: from inputplus.co.uk [66.39.34.92]
	by localhost with POP3 (fetchmail-5.9.0)
	for ralph@localhost (single-drop); Fri, 24 Sep 2004 14:13:40 +0100 (BST)
Received: (qmail 42269 invoked from network); 24 Sep 2004 13:07:22 -0000
Received: from mail.amstrad.co.uk (HELO mrs.amstrad.co.uk) (193.133.25.43)
  by ruis.pair.com with SMTP; 24 Sep 2004 13:07:22 -0000
Received: from mailserver2.amstrad.co.uk ([192.9.200.8]) by mrs.amstrad.co.uk with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 24 Sep 2004 14:07:21 +0100
Received: by MAILSERVER2 with Internet Mail Service (5.5.2653.19)
	id <SST6CYKP>; Fri, 24 Sep 2004 14:07:21 +0100
Message-ID: <EC49BB70F1DDD6118C620002B3512AD5039BD5D3@MAILSERVER2>
From: Amserve Support <support@amserve.ltd.uk>
To: "'Ralph Corderoy'" <ralph@inputplus.co.uk>
Subject: RE: Source for E3's MontaVista Linux.
Date: Fri, 24 Sep 2004 14:07:19 +0100
X-Mailer: Internet Mail Service (5.5.2653.19)
X-OriginalArrivalTime: 24 Sep 2004 13:07:21.0679 (UTC) FILETIME=[6D7965F0:01C4A237]
X-Spam-Filtered: 52d0813afd638bc4ffa68db06ca49a29
X-Spam-Status: No, hits=-4.9 required=4.0 tests=BAYES_00
X-Spam-Flag: NO
X-Spam-Level: 

Thank you for your email.

Please provide the serial number from your E3 unit (located on the underside
of the unit or by pressing SETUP and option 1) so that we can provide these
details.

Regards

Amserve Support

- -----Original Message-----

[Snip duplicate of message 1.]

------- Message 3

Return-Path: ralph@inputplus.co.uk
Delivery-Date: Sat Sep 25 10:20:53 2004
Return-Path: <ralph@inputplus.co.uk>
Received: from blake.inputplus.co.uk (ralph@localhost)
	by blake.inputplus.co.uk (8.11.6/8.11.6) with ESMTP id i8P9Krn05212;
	Sat, 25 Sep 2004 10:20:53 +0100
Message-Id: <200409250920.i8P9Krn05212@blake.inputplus.co.uk>
To: Amserve Support <support@amserve.ltd.uk>
Subject: Re: Source for E3's MontaVista Linux. 
In-Reply-To: Message from Amserve Support <support@amserve.ltd.uk> 
   of "Fri, 24 Sep 2004 14:07:19 BST." <EC49BB70F1DDD6118C620002B3512AD5039BD5D3@MAILSERVER2> 
Date: Sat, 25 Sep 2004 10:20:53 +0100
From: Ralph Corderoy <ralph@inputplus.co.uk>


Dear Support,

Thanks for your prompt reply.

> > I see from the joint MontaVista/Amstrad press release that
> > MontaVista Linux has been chosen for the E3's operating system.
> > I've had a hunt around the amstrad.co.uk web site and haven't been
> > able to find a download of the source for the binaries shipped on
> > the E3 that are covered by the GNU General Public License.
> > 
> > Could you please let me know how to obtain them.
>
> Please provide the serial number from your E3 unit (located on the
> underside of the unit or by pressing SETUP and option 1) so that we
> can provide these details.

I can't do that as I don't have an E3.  I was assuming that out of the
three choices, a, b, or c, from section 3 of the GNU GPL, Amstrad had
chosen b.

    http://www.gnu.org/copyleft/gpl.html#SEC3

    You may copy and distribute the Program (or a work based on it,
    under Section 2) in object code or executable form under the terms
    of Sections 1 and 2 above provided that you also do one of the
    following:

        a) Accompany it with the complete corresponding machine-readable
        source code, which must be distributed under the terms of
        Sections 1 and 2 above on a medium customarily used for software
        interchange; or,

Let me know if a has been chosen and I'll contact an E3 owner who'll
already have the source and may be willing to distribute it to me.

        b) Accompany it with a written offer, valid for at least three
        years, to give any third party, for a charge no more than your
        cost of physically performing source distribution, a complete
        machine-readable copy of the corresponding source code, to be
        distributed under the terms of Sections 1 and 2 above on a
        medium customarily used for software interchange; or,

I assumed Amstrad chose b and I am turning up as `any third party'
requesting a copy of the source code.  

        c) Accompany it with the information you received as to the
        offer to distribute corresponding source code. (This alternative
        is allowed only for noncommercial distribution and only if you
        received the program in object code or executable form with such
        an offer, in accord with Subsection b above.) 

c doesn't seem a possible choice for Amstrad.

a is a useful one because it means that parties cannot request source
from Amstrad as Amstrad ensured source travelled with all binaries.  It
becomes more awkward if the device may update its GPL'd software after
shipping to the customer though.

To save overhead, b can be largely satisfied by making the various
versions of source available on the Internet for download as they are
distributed in binary form.  Most people wanting the source would prefer
this method although as I understand it Internet access alone isn't
sufficient to satisfy section 3 and a physical medium, obtainable by
mail-order, must also be available even if no one ever uses it.

As ever with these things, I am not a lawyer so if you think my
interpretation is wrong I'd like to know.  Otherwise, could you please
let me know which one of 3a, 3b, and 3c Amstrad have chosen so I can
continue in trying to obtain the GPL'd source.

Thanks,


Ralph.

------- Message 4

Return-Path: support@amserve.ltd.uk
Delivery-Date: Mon Sep 27 11:39:07 2004
Return-Path: <support@amserve.ltd.uk>
Received: from localhost (localhost [127.0.0.1])
	by blake.inputplus.co.uk (8.11.6/8.11.6) with ESMTP id i8RAd7A05038
	for <ralph@localhost>; Mon, 27 Sep 2004 11:39:07 +0100
Delivered-To: inputplu-inputplus:co:uk-ralph@inputplus.co.uk
X-Envelope-To: ralph@inputplus.co.uk
Received: from inputplus.co.uk [66.39.34.92]
	by localhost with POP3 (fetchmail-5.9.0)
	for ralph@localhost (single-drop); Mon, 27 Sep 2004 11:39:07 +0100 (BST)
Received: (qmail 36748 invoked from network); 27 Sep 2004 10:26:30 -0000
Received: from mail.amstrad.co.uk (HELO mrs.amstrad.co.uk) (193.133.25.43)
  by ruis.pair.com with SMTP; 27 Sep 2004 10:26:30 -0000
Received: from mailserver2.amstrad.co.uk ([192.9.200.8]) by mrs.amstrad.co.uk with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 27 Sep 2004 11:26:27 +0100
Received: by MAILSERVER2 with Internet Mail Service (5.5.2653.19)
	id <SST6DJTP>; Mon, 27 Sep 2004 11:26:27 +0100
Message-ID: <EC49BB70F1DDD6118C620002B3512AD5039BD60F@MAILSERVER2>
From: Amserve Support <support@amserve.ltd.uk>
To: "'ralph@inputplus.co.uk'" <ralph@inputplus.co.uk>
Subject: FW: Source for E3's MontaVista Linux. 
Date: Mon, 27 Sep 2004 11:26:21 +0100
X-Mailer: Internet Mail Service (5.5.2653.19)
X-OriginalArrivalTime: 27 Sep 2004 10:26:27.0492 (UTC) FILETIME=[725E9E40:01C4A47C]
X-Spam-Filtered: 52d0813afd638bc4ffa68db06ca49a29
X-Spam-Status: No, hits=-4.9 required=4.0 tests=BAYES_00
X-Spam-Flag: NO
X-Spam-Level: 


Amserve will require the following information in order to divulge any
further informatiom
 
Date of Purchase
 
Retailer
 
Serial Number of E Mailer unit
 
E Mail address.
 
Telephone number
 
Regards  Amserve


- -----Original Message-----

[Snip duplicate of message 3.]

------- Message 5

Return-Path: ralph@inputplus.co.uk
Delivery-Date: Mon Sep 27 13:08:08 2004
Return-Path: <ralph@inputplus.co.uk>
Received: from blake.inputplus.co.uk (ralph@localhost)
	by blake.inputplus.co.uk (8.11.6/8.11.6) with ESMTP id i8RC88D06215;
	Mon, 27 Sep 2004 13:08:08 +0100
Message-Id: <200409271208.i8RC88D06215@blake.inputplus.co.uk>
To: Amserve Support <support@amserve.ltd.uk>
Subject: Re: FW: Source for E3's MontaVista Linux. 
In-Reply-To: Message from Amserve Support <support@amserve.ltd.uk> 
   of "Mon, 27 Sep 2004 11:26:21 BST." <EC49BB70F1DDD6118C620002B3512AD5039BD60F@MAILSERVER2> 
Date: Mon, 27 Sep 2004 13:08:08 +0100
From: Ralph Corderoy <ralph@inputplus.co.uk>


Dear Support,

> > > Please provide the serial number from your E3 unit (located on the
> > > underside of the unit or by pressing SETUP and option 1) so that
> > > we can provide these details.
> > 
> > I can't do that as I don't have an E3.  I was assuming that out of
> > the three choices, a, b, or c, from section 3 of the GNU GPL,
> > Amstrad had chosen b.
> > 
> > ...
> > 
> > As ever with these things, I am not a lawyer so if you think my
> > interpretation is wrong I'd like to know.  Otherwise, could you
> > please let me know which one of 3a, 3b, and 3c Amstrad have chosen
> > so I can continue in trying to obtain the GPL'd source.
>
> Amserve will require the following information in order to divulge any
> further informatiom
>  
> Date of Purchase, Retailer, Serial Number of E Mailer unit, E Mail
> address, Telephone number.

Could you answer a simpler question?  If I buy an E3 at Dixons and open
it will I find the GPL'd source code in the box, or will I find a
written offer to provide it?  It must be one of these two otherwise
Amstrad are in violation of the GNU GPL version 2, as explained in my
previous email, that covers some of the binaries shipped in the E3 and
as such their rights under the GPL are terminated, see section 4.

    4. You may not copy, modify, sublicense, or distribute the Program
    except as expressly provided under this License.  Any attempt
    otherwise to copy, modify, sublicense or distribute the Program is
    void, and will automatically terminate your rights under this
    License.  However, parties who have received copies, or rights, from
    you under this License will not have their licenses terminated so
    long as such parties remain in full compliance.

In other words, Amstrad would be infringing copyright by selling E3s
which is a serious and easily avoidable situation.

This almost certainly isn't the case, but issuing a standard `please
supply your serial number' to all enquiries is inadequate if section 3b
of the GPL has been followed.

If that's the only procedure that has been presented to Amserve Support
perhaps my simpler question above can be passed internally to an area
that deals with licensing and copyright.  

Thanks,


Ralph.

------- Message 6

Return-Path: support@amserve.ltd.uk
Delivery-Date: Mon Sep 27 14:16:59 2004
Return-Path: <support@amserve.ltd.uk>
Received: from localhost (localhost [127.0.0.1])
	by blake.inputplus.co.uk (8.11.6/8.11.6) with ESMTP id i8RDGwA09799
	for <ralph@localhost>; Mon, 27 Sep 2004 14:16:58 +0100
Delivered-To: inputplu-inputplus:co:uk-ralph@inputplus.co.uk
X-Envelope-To: ralph@inputplus.co.uk
Received: from inputplus.co.uk [66.39.34.92]
	by localhost with POP3 (fetchmail-5.9.0)
	for ralph@localhost (single-drop); Mon, 27 Sep 2004 14:16:58 +0100 (BST)
Received: (qmail 91407 invoked from network); 27 Sep 2004 13:08:11 -0000
Received: from mail.amstrad.co.uk (HELO mrs.amstrad.co.uk) (193.133.25.43)
  by ruis.pair.com with SMTP; 27 Sep 2004 13:08:11 -0000
Received: from mailserver2.amstrad.co.uk ([192.9.200.8]) by mrs.amstrad.co.uk with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 27 Sep 2004 14:08:10 +0100
Received: by MAILSERVER2 with Internet Mail Service (5.5.2653.19)
	id <SST6DKP0>; Mon, 27 Sep 2004 14:08:10 +0100
Message-ID: <EC49BB70F1DDD6118C620002B3512AD5039BD615@MAILSERVER2>
From: Amserve Support <support@amserve.ltd.uk>
To: "'Ralph Corderoy'" <ralph@inputplus.co.uk>
Subject: RE: FW: Source for E3's MontaVista Linux. 
Date: Mon, 27 Sep 2004 14:08:08 +0100
X-Mailer: Internet Mail Service (5.5.2653.19)
X-OriginalArrivalTime: 27 Sep 2004 13:08:10.0774 (UTC) FILETIME=[09F9F360:01C4A493]
X-Spam-Filtered: 52d0813afd638bc4ffa68db06ca49a29
X-Spam-Status: No, hits=-4.9 required=4.0 tests=BAYES_00
X-Spam-Flag: NO
X-Spam-Level: 

Thank you for your email.

We are happy to explain how we comply with the GPL to our customers. To
date, it appears that this is not so in your case. Should you purchase an E3
personal communication centre and wish to continue this correspondence,
please provide us with the unit serial number, registered email address and
purchase details we have previously requested. Following which, we will
forward the necessary information.

Regards

Amserve Support 

- -----Original Message-----

[Snip duplicate of message 5.]

------- Message 7

Return-Path: ralph@inputplus.co.uk
Delivery-Date: Mon Sep 27 23:33:22 2004
Return-Path: <ralph@inputplus.co.uk>
Received: from blake.inputplus.co.uk (ralph@localhost)
	by blake.inputplus.co.uk (8.11.6/8.11.6) with ESMTP id i8RMXLd04471;
	Mon, 27 Sep 2004 23:33:21 +0100
Message-Id: <200409272233.i8RMXLd04471@blake.inputplus.co.uk>
To: Sir Alan Sugar <asugar@amstrad.com>
Subject: Possible GNU GPL License Violation by Amstrad E3.
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <4142.1096322842.0@blake.inputplus.co.uk>
Date: Mon, 27 Sep 2004 23:33:21 +0100
From: Ralph Corderoy <ralph@inputplus.co.uk>

- ------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4142.1096322842.1@blake.inputplus.co.uk>

Dear Sir Alan,

Since last Thursday I've been conversing by email with
support@amserve.ltd.uk regarding the meeting the license conditions of
some parts of the software that ships with Amstrad's E3.  In particular,
the Linux kernel used on the E3, as announced in a joint
Amstrad/MontaVista press release, is covered by the GNU General Public
License, GPL, version 2.

    http://www.amstrad.com/news_linux.html

Perhaps understandably, given their role in supporting owners of an E3,
Support are reluctant to discuss the license compliance further unless I
can provide a serial number, etc., which, given I've not purchased an
E3, I don't have.  Consequently, I'm writing to you in the hope of
straightening out any license infringement, or correcting my
understanding.  Let me make clear, I'm delighted Amstrad have used Linux
on the E3 and wish nothing more than to see Linux's license complied
with allowing me to obtain the GPL'd source code under the terms of the
license -- I have no wish to damage Amstrad's reputation in any way.
I'm hoping you can forward my concerns onto the relevant party inside
Amstrad.

The GNU GPL version 2 aims to ensure that recipients of a GPL'd program
in object code or executable form, e.g. E3 purchaser, can obtain the
exact same source code that created the binary files.  The whole license
is available at

    http://www.gnu.org/copyleft/gpl.html

I think the core issue is that Amstrad received the Linux kernel
licensed under the GPL and must therefore follow its conditions in their
distribution of Linux, as stored in the E3.

I believe section 3 of the GPL is the relevant part.  It starts

    3.  You may copy and distribute the Program (or a work based on it,
    under Section 2) in object code or executable form under the terms
    of Sections 1 and 2 above provided that you also do one of the
    following:

and the E3 contains a work based on Linux in executable form.

The three choices allowed are

        a) Accompany it with the complete corresponding machine-readable
        source code, which must be distributed under the terms of
        Sections 1 and 2 above on a medium customarily used for software
        interchange; or,

        b) Accompany it with a written offer, valid for at least three
        years, to give any third party, for a charge no more than your
        cost of physically performing source distribution, a complete
        machine-readable copy of the corresponding source code, to be
        distributed under the terms of Sections 1 and 2 above on a
        medium customarily used for software interchange; or,

        c) Accompany it with the information you received as to the
        offer to distribute corresponding source code. (This alternative
        is allowed only for noncommercial distribution and only if you
        received the program in object code or executable form with such
        an offer, in accord with Subsection b above.)

Complying with (a) would mean the source code is in the box, probably on
a CD, alongside the E3.

(b) would mean there's a written offer in the E3's box to give *any
third party*, not just an E3 purchaser, i.e. me, the source code at
cost.

I don't believe (c) is available to Amstrad since the E3 is a commercial
distribution and I doubt Amstrad received Linux in non-source form from
MontaVista.

Visiting my local Dixons today, and with the help of an assistant who
let me go through a new E3 box, I have the serial number if that's of
help, I found no source code (a), and no written offer (b).  Just a
"This product contains software that is subject to licence terms."
inside the manual's front cover.  Thus I believe Amstrad are violating
the terms of Linux's license in not doing one of 3(a), 3(b), or 3(c).

This is the most apparent violation but I am not a lawyer and I've no
doubt that Amstrad had lawyers and assistance from MontaVista in looking
over the GPL before shipping the E3.  If I'm wrong I'd like to know
Amstrad's interpretation of the license and how they comply and they may
wish to publicise their compliance in order that others don't follow me
in asking.

Otherwise, if Amstrad are violating the GPL then, under section 4, their
rights to distribute the program are terminated, i.e. distributing the
E3 is copyright infringement.

    4.  You may not copy, modify, sublicense, or distribute the Program
    except as expressly provided under this License. Any attempt
    otherwise to copy, modify, sublicense or distribute the Program is
    void, and will automatically terminate your rights under this
    License. However, parties who have received copies, or rights, from
    you under this License will not have their licenses terminated so
    long as such parties remain in full compliance.

I have further minor issues with GPL compliance but section 3 is the
main one.  Others include

    The manual stating "Software (C) Amstrad plc.  1999-2004.  All
    rights reserved.";  clearly some of the software's copyright doesn't
    reside with Amstrad but with Linux's copyright holders.

    Page 155 states

        "You must not copy, de-compile, modify, change, sell, lend,
        sub-license or by other means interfere with or exploit the
        software of the e-m@iler.  Nor must you change the
        factory-installed software in the e-m@iler, except where such
        change is an upgrade or modification version released by
        Amserve."

    but section 3 allows me to copy and distribute the GPL'd binaries I
    received in the E3 as long as I comply with 3(c), i.e. don't charge
    for distribution and accompany it with the written offer I (didn't)
    receive with the E3.  Attempting to restrict my right to do this
    violates GPL section 6.

        6. Each time you redistribute the Program (or any work based on
        the Program), the recipient automatically receives a license
        from the original licensor to copy, distribute or modify the
        Program subject to these terms and conditions. You may not
        impose any further restrictions on the recipients' exercise of
        the rights granted herein. You are not responsible for enforcing
        compliance by third parties to this License.

I suspect these arise from taking the Emailer Plus manual and altering
it for the E3 without considering GPL compliance.

One further tricky point to consider is section 3 clarifies

    The source code for a work means the preferred form of the work for
    making modifications to it. For an executable work, complete source
    code means all the source code for all modules it contains, plus any
    associated interface definition files, plus the scripts used to
    control compilation and installation of the executable.

This means that each time Amstrad alter and distribute the GPL'd
software on the E3, e.g. an improvement to Linux to support wireless LAN
downloaded to the E3 overnight, they must make available the matching
source code, build, and installation scripts.

I'd like to know if Amstrad agree that they're violating the GPL and
what they intend to change to try and follow the spirit of the GPL
despite having already shipped E3s.  As I'm not a copyright holder of
any part of the Linux kernel I obviously have no right to condone any
changes.  I'm merely trying to obtain the source code and see the
license complied with for the good of all Linux licensees, including
Amstrad.

Below are my recent emails with Support.

Thanks,


Ralph Corderoy.


- ------- =_aaaaaaaaaa0
Content-Type: multipart/digest; boundary="----- =_aaaaaaaaaa1"
Content-ID: <4142.1096322842.2@blake.inputplus.co.uk>

- ------- =_aaaaaaaaaa1
Content-Type: message/rfc822

[Snip duplicate of message 1-6.]

- ------- =_aaaaaaaaaa1--

- ------- =_aaaaaaaaaa0--

------- Message 8

Return-Path: brian.eaton@amstrad.com
Delivery-Date: Tue Sep 28 11:13:00 2004
Return-Path: <brian.eaton@amstrad.com>
Received: from localhost (localhost [127.0.0.1])
	by blake.inputplus.co.uk (8.11.6/8.11.6) with ESMTP id i8SACxh12987
	for <ralph@localhost>; Tue, 28 Sep 2004 11:13:00 +0100
Delivered-To: inputplu-inputplus:co:uk-ralph@inputplus.co.uk
X-Envelope-To: ralph@inputplus.co.uk
Received: from inputplus.co.uk [66.39.34.92]
	by localhost with POP3 (fetchmail-5.9.0)
	for ralph@localhost (single-drop); Tue, 28 Sep 2004 11:13:00 +0100 (BST)
Received: (qmail 98079 invoked from network); 28 Sep 2004 09:50:33 -0000
Received: from mail.amstrad.co.uk (HELO mrs.amstrad.co.uk) (193.133.25.43)
  by ruis.pair.com with SMTP; 28 Sep 2004 09:50:33 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Received: from mailserver2.amstrad.co.uk ([192.9.200.8]) by mrs.amstrad.co.uk with Microsoft SMTPSVC(5.0.2195.6713); Tue, 28 Sep 2004 10:50:32 +0100
Received: by MAILSERVER2 with Internet Mail Service (5.5.2653.19) id <SST6DRVG>; Tue, 28 Sep 2004 10:50:32 +0100
Message-ID: <EC49BB70F1DDD6118C620002B3512AD50329D2EF@MAILSERVER2>
From: Brian Eaton <brian.eaton@amstrad.com>
To: "'ralph@inputplus.co.uk'" <ralph@inputplus.co.uk>
CC: Amserve Support <support@amserve.ltd.uk>
Subject: RE: Possible GNU GPL License Violation by Amstrad E3.
Date: Tue, 28 Sep 2004 10:50:22 +0100
X-Mailer: Internet Mail Service (5.5.2653.19)
X-OriginalArrivalTime: 28 Sep 2004 09:50:32.0312 (UTC) FILETIME=[9831FF80:01C4A540]
X-Spam-Filtered: 52d0813afd638bc4ffa68db06ca49a29
X-Spam-Status: No, hits=-1.5 required=4.0 tests=MISSING_OUTLOOK_NAME,BAYES_01
X-Spam-Flag: NO
X-Spam-Level: 
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by blake.inputplus.co.uk id i8SACxh12987

Dear Mr Corderoy

I refer to the email of 27 Sept that you sent to Sir Alan Sugar. Sir Alan
has asked me to respond.

Please note the following:

We have an obligation to our customers (the recipients of the object code)
to make the source code of the kernel (not the whole of our code) available
to them. You, with respect, are not a customer. Our customer services -
after asking for proof of purchase and registration - will point customers
to a web address where the kernel can be found.

Our position is that
1) You are not one of our customers. We only have obligations to our
customers (the recipients). We do have an obligation to the copyright owners
of Linux, but with respect you are not one of them either.
2) We have told everyone clearly that we are working with MontaVista and
using their Linux.

Yours sincerely

Brian Eaton
E-Business Director
Amstrad Plc 




This e-mail and any attachments are confidential and intended exclusively for the addressee. If you are not the intended recipient please delete it from your system and notify the sender immediately. This message is attributed to the sender and may not necessarily reflect the views of Amstrad Plc or its subsidiaries.

For further information on Amstrad Plc please visit our website: www.amstrad.com

Amstrad Plc.
Brentwood House
169 Kings Road
Brentwood
Essex CM14 4EF
Registered in England : No. 955321



------- Message 9

Return-Path: ralph@inputplus.co.uk
Delivery-Date: Tue Sep 28 16:06:37 2004
Return-Path: <ralph@inputplus.co.uk>
Received: from blake.inputplus.co.uk (ralph@localhost)
	by blake.inputplus.co.uk (8.11.6/8.11.6) with ESMTP id i8SF6bG17264;
	Tue, 28 Sep 2004 16:06:37 +0100
Message-Id: <200409281506.i8SF6bG17264@blake.inputplus.co.uk>
To: Brian Eaton <brian.eaton@amstrad.com>
cc: Amserve Support <support@amserve.ltd.uk>
Subject: Re: Possible GNU GPL License Violation by Amstrad E3. 
In-Reply-To: Message from Brian Eaton <brian.eaton@amstrad.com> 
   of "Tue, 28 Sep 2004 10:50:22 BST." <EC49BB70F1DDD6118C620002B3512AD50329D2EF@MAILSERVER2> 
Date: Tue, 28 Sep 2004 16:06:37 +0100
From: Ralph Corderoy <ralph@inputplus.co.uk>


Dear Mr. Eaton,

> I refer to the email of 27 Sept that you sent to Sir Alan Sugar. Sir
> Alan has asked me to respond.

Thank you.

> Please note the following:
> 
> We have an obligation to our customers (the recipients of the object
> code) to make the source code of the kernel (not the whole of our
> code) available to them.

You have an obligation under the GNU GPL to supply your customers, who
are the E3 purchasers and initial recipients of the GPL'd object code,
with either the source code alongside the E3 (3a), or a written offer to
any third party to supply the source code (3b).  From inspection of the
E3's box's contents I believe you're doing neither and hence are in
violation of the GPL.

There is no disagreement that not all of the software on the E3 is
licensed under the GPL.

> You, with respect, are not a customer. Our customer services - after
> asking for proof of purchase and registration - will point customers
> to a web address where the kernel can be found.

No, I'm not a customer.  I'm just someone who's contributing my own free
time to try and help Amstrad comply with the license without it all
snowballing into a situation like the Welte v. Sitecom De*tschland GmbH
case in the Munchen District Court where an injunction on Sitecom was
upheld.

You seem to feel that supplying E3 owners, on proof of purchase, with a
web address where the source can be found meets your obligations under
the GPL.  It doesn't.  You seem to be going for 3(b) of the GPL where
source is made available separately from the object code.  But an
important part of the GPL is that recipients of GPL'd code know it is
GPL'd and what their rights are.  Hence 3(b)'s `written offer' which
informs the E3 owner of their rights and which owners of the E3 can pass
on when copying the E3's GPL'd object code to anyone they wish under
3(c).

Someone who receives the E3's GPL'd binaries along with Amstrad's
written offer, either by purchasing an E3, or by being passed both by
someone who already has them, can take up Amstrad's offer of supplying
the source code *to any third party* despite not owning an E3 or having
its serial number.

Anyone who has the GPL'd source code from Amstrad can, under section 1
of the GPL, make it available, e.g. on the Internet, to all and sundry.
Given this, Amstrad's attempt to seemingly keep it to E3 owners only, or
track distribution by serial number, seems mis-guided.

> Our position is that 1) You are not one of our customers. We only have
> obligations to our customers (the recipients). We do have an
> obligation to the copyright owners of Linux, but with respect you are
> not one of them either.

Despite not being a customer, or a copyright holder, I believe that
Amstrad are failing to comply with the GPL.  If Amstrad continue to fail
to answer the specific points I've made I will take the matter to the
Linux kernel copyright holders by posting the issue on the public Linux
Kernel Mailing List, linux-kernel@vger.kernel.org.

> 2) We have told everyone clearly that we are working with MontaVista
> and using their Linux.

I am surprised MontaVista have not advised Amstrad more precisely over
their obligations.  You may wish to consult them again.

Thanks,


Ralph Corderoy.

------- Message 10

Return-Path: brian.eaton@amstrad.com
Delivery-Date: Tue Sep 28 17:13:43 2004
Return-Path: <brian.eaton@amstrad.com>
Received: from localhost (localhost [127.0.0.1])
	by blake.inputplus.co.uk (8.11.6/8.11.6) with ESMTP id i8SGDgh19211
	for <ralph@localhost>; Tue, 28 Sep 2004 17:13:43 +0100
Delivered-To: inputplu-inputplus:co:uk-ralph@inputplus.co.uk
X-Envelope-To: ralph@inputplus.co.uk
Received: from inputplus.co.uk [66.39.34.92]
	by localhost with POP3 (fetchmail-5.9.0)
	for ralph@localhost (single-drop); Tue, 28 Sep 2004 17:13:43 +0100 (BST)
Received: (qmail 31142 invoked from network); 28 Sep 2004 16:10:10 -0000
Received: from mail.amstrad.co.uk (HELO mrs.amstrad.co.uk) (193.133.25.43)
  by ruis.pair.com with SMTP; 28 Sep 2004 16:10:10 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Received: from mailserver2.amstrad.co.uk ([192.9.200.8]) by mrs.amstrad.co.uk with Microsoft SMTPSVC(5.0.2195.6713); Tue, 28 Sep 2004 17:10:09 +0100
Received: by MAILSERVER2 with Internet Mail Service (5.5.2653.19) id <SST6DT0L>; Tue, 28 Sep 2004 17:10:09 +0100
Message-ID: <EC49BB70F1DDD6118C620002B3512AD50329D2F6@MAILSERVER2>
From: Brian Eaton <brian.eaton@amstrad.com>
To: "'Ralph Corderoy'" <ralph@inputplus.co.uk>
Subject: RE: Possible GNU GPL License Violation by Amstrad E3. 
Date: Tue, 28 Sep 2004 17:10:08 +0100
X-Mailer: Internet Mail Service (5.5.2653.19)
X-OriginalArrivalTime: 28 Sep 2004 16:10:09.0971 (UTC) FILETIME=[A0BCF030:01C4A575]
X-Spam-Filtered: 52d0813afd638bc4ffa68db06ca49a29
X-Spam-Status: No, hits=-4.9 required=4.0 tests=MISSING_OUTLOOK_NAME,BAYES_00
X-Spam-Flag: NO
X-Spam-Level: 
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by blake.inputplus.co.uk id i8SGDgh19211

Dear Mr Corderoy
Your comments are noted. We will get back to you shortly. In the meantime
can you let me have your postal address please so that I can send you
something?
Yours sincerely
Brian Eaton
E-Business Director
Amstrad Plc 


- -----Original Message-----

[Snip duplicate of message 9.]


This e-mail and any attachments are confidential and intended exclusively for the addressee. If you are not the intended recipient please delete it from your system and notify the sender immediately. This message is attributed to the sender and may not necessarily reflect the views of Amstrad Plc or its subsidiaries.

For further information on Amstrad Plc please visit our website: www.amstrad.com

Amstrad Plc.
Brentwood House
169 Kings Road
Brentwood
Essex CM14 4EF
Registered in England : No. 955321



------- Message 11

Return-Path: brian.eaton@amstrad.com
Delivery-Date: Wed Sep 29 12:48:50 2004
Return-Path: <brian.eaton@amstrad.com>
Received: from localhost (localhost [127.0.0.1])
	by blake.inputplus.co.uk (8.11.6/8.11.6) with ESMTP id i8TBmmW09654
	for <ralph@localhost>; Wed, 29 Sep 2004 12:48:50 +0100
Delivered-To: inputplu-inputplus:co:uk-ralph@inputplus.co.uk
X-Envelope-To: ralph@inputplus.co.uk
Received: from inputplus.co.uk [66.39.34.92]
	by localhost with POP3 (fetchmail-5.9.0)
	for ralph@localhost (single-drop); Wed, 29 Sep 2004 12:48:50 +0100 (BST)
Received: (qmail 18673 invoked from network); 29 Sep 2004 11:46:24 -0000
Received: from mail.amstrad.co.uk (HELO mrs.amstrad.co.uk) (193.133.25.43)
  by ruis.pair.com with SMTP; 29 Sep 2004 11:46:24 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Received: from mailserver2.amstrad.co.uk ([192.9.200.8]) by mrs.amstrad.co.uk with Microsoft SMTPSVC(5.0.2195.6713); Wed, 29 Sep 2004 12:46:22 +0100
Received: by MAILSERVER2 with Internet Mail Service (5.5.2653.19) id <SST6DZBZ>; Wed, 29 Sep 2004 12:46:23 +0100
Message-ID: <EC49BB70F1DDD6118C620002B3512AD50329D301@MAILSERVER2>
From: Brian Eaton <brian.eaton@amstrad.com>
To: "'Ralph Corderoy'" <ralph@inputplus.co.uk>
CC: Amserve Support <support@amserve.ltd.uk>
Subject: RE: Possible GNU GPL License Violation by Amstrad E3. 
Date: Wed, 29 Sep 2004 12:46:22 +0100
X-Mailer: Internet Mail Service (5.5.2653.19)
X-OriginalArrivalTime: 29 Sep 2004 11:46:22.0618 (UTC) FILETIME=[F15047A0:01C4A619]
X-Spam-Filtered: 52d0813afd638bc4ffa68db06ca49a29
X-Spam-Status: No, hits=-3.4 required=4.0 tests=MISSING_OUTLOOK_NAME,NO_OBLIGATION,BAYES_00
X-Spam-Flag: NO
X-Spam-Level: 
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by blake.inputplus.co.uk id i8TBmmW09654

Dear Mr Corderoy

Any customer who buys one of our videophones will see that our
obligations under the GPL are met and clearly explained to them. If you
were to become a customer it would be clear to you. In the meantime we have
no
obligation to explain to non-customers our policy.

Brian Eaton
E-Business Director
Amstrad Plc 


- -----Original Message-----

[Snip duplicate of message 9.]


This e-mail and any attachments are confidential and intended exclusively for the addressee. If you are not the intended recipient please delete it from your system and notify the sender immediately. This message is attributed to the sender and may not necessarily reflect the views of Amstrad Plc or its subsidiaries.

For further information on Amstrad Plc please visit our website: www.amstrad.com

Amstrad Plc.
Brentwood House
169 Kings Road
Brentwood
Essex CM14 4EF
Registered in England : No. 955321



------- End of Forwarded Messages

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTFGALv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbTFGALv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:11:51 -0400
Received: from mail.casabyte.com ([209.63.254.226]:17420 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S262400AbTFGALt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:11:49 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Linus Torvalds" <torvalds@transmeta.com>,
       "Albert Cahalan" <albert@users.sourceforge.net>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, <davem@redhat.com>,
       <bcollins@debian.org>, <wli@holomorphy.com>, <tom_gall@vnet.ibm.com>,
       <anton@samba.org>
Subject: RE: /proc/bus/pci
Date: Fri, 6 Jun 2003 17:25:00 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGEELACOAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44.0306050847410.9939-100000@home.transmeta.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Humble Opinion:

"hose0" -> bad, I know I didn't have a clue where it came from

"domain0" -> obscure but mathematical 8-), probably hard to teach what with
the name used all over heck

"phb0" -> "eh what is phb?"  "primary host bridge"...

"bridge0" -> not bad, is it platform agnostic? (e.g. is the connection
called a bridge on non- Intel/AMD/PS platforms?)  don't know...  but if it
is... good

Note:  There are no "good" synonyms for "Domain"  (from M-W.com:)

"field, bailiwick, champaign, demesne, dominion, province, sphere, terrain,
territory, walk"

So, my heard groans for another "domain" in the computer, and I like the way
bridge reads

"devices/bridge0/bus2/dev11/fn0/whatever"

but regardless (going back to pc-isms) that puts things like the pci-agp
"bridge" and such into the namespace if one were to be especially
conformant, which may or may not be a good thing.

Rob.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Linus Torvalds
Sent: Thursday, June 05, 2003 8:52 AM
To: Albert Cahalan
Cc: linux-kernel; davem@redhat.com; bcollins@debian.org;
wli@holomorphy.com; tom_gall@vnet.ibm.com; anton@samba.org
Subject: Re: /proc/bus/pci



On Thu, 5 Jun 2003, Albert Cahalan wrote:
>
> Some of the IBMers use "phb" instead of "hose" or "domain".

Gods, did they run out of vowels in _that_ part of IBM too?

Where do they go? Is there somebody at IBM that hoards vowels, and will
one day hold the rest of the world hostage? "Mwahahahaa! If you don't buy
support from IBM, you can never use the letter 'A' again! Whahahahhhaah!".

I can see it now.


What the _f*ck_ is wrong with just calling it "PCI domain". It's a fine
word, and yes, "domain" is used commonly in computer language, but that's
a _good_ thing. Everybody immediately understands what it is about.

There is no goodness to acronyms where you have to be some "insider" to
know what the hell it means. That "hose" thing has the same problem: I
don't know about anybody else, but to me a "hose" is a logn narrow conduit
for water, and a "PCI hose" doesn't much make sense to me.

A "phb" just makes me go "Whaa?"

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


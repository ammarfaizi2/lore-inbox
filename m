Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTDKWld (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbTDKWld (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:41:33 -0400
Received: from marstons.services.quay.plus.net ([212.159.14.223]:25297 "HELO
	marstons.services.quay.plus.net") by vger.kernel.org with SMTP
	id S261968AbTDKWlb (for <rfc822;Linux-Kernel@vger.kernel.org>); Fri, 11 Apr 2003 18:41:31 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Robert White" <rwhite@casabyte.com>,
       "Linux Kernel List" <Linux-Kernel@vger.kernel.org>
Subject: RE: kernel support for non-English user messages
Date: Fri, 11 Apr 2003 23:53:21 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAGEEBCGAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGGEBPCHAA.rwhite@casabyte.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert.

 > Actually, my final point had been that doing it inside the kernel
 > itself, or indeed inside klogd, was probably a very bad idea. If
 > the translation always happens after-the-fact based on properly
 > harvested message semantics then any segment of messages
 > distributed into this mailing list (among other uses) would be
 >
 > A)  Still in English.
 > B)  Translatable after the fact there too.
 >
 > Also after-the-fact translation makes the language translations a
 > scalar problem instead of a matrix one. That is, if you always
 > pass the message stream around in English (treat it like n opaque
 > source file) and then translate it as necessary, it will "always
 > work".
 >
 > If you try to do the translations at message generation time, then
 > the translation must be any-language-to-any-language capable during
 > post-even discussions. Not good.

I can see the points you're making, and that is precisely why I believe
that message codes would be required to implement this idea. As Linus
has vetoed the idea of having message codes in the kernel, I can't see
it ever coming to fruition.

 > Also, you will always have leakage as people add new strings to the
 > set.

That's the easiest aspect of dealing with it - the tool that generates
the language set to use just grabs the "English" language version for
any message codes not in the selected translation.

 > As for the #define issues, when you process the source tree to build the
 > source matrix you just "gcc -E file.c | collector" and now the printk
 > case you mention is handled. Any module designer who does uglier things
 > can make a dead-code procedure that expresses his possible output strings
 > for collection (if he cares.)

 > {Satire}

 > Speaking as an arrogant (U.S. of) American who knows that God(TradeMark,
 > all rights reserved) decreed that he never had to learn any language but
 > his own, I can honestly state, that it is nearly certain that you will
 > get no real support for the multi-language kernel out of a us
USAmericans.
 > We can't even get ourselves to write decent comments, and on the average,
 > we all secretly believe that if we just speak slowly enough everybody
 > really knows English. After all, that's how our condescending "wouldn't
 > want to fail Johnny, it would be bad for his self-image" public schools
 > taught us in the first place.... 8-)

Speaking as an amused (U.S. of) American, I long ago learned how to tell
when
somebody is speaking "God's Language"(tm) - that's simple to work out. After
all, the most likely people to speak "God's Language"(tm) are those that
have
just left His presence - the new born babies - so if we want to listen to
His
language, we just listen to them speak it. What could be simpler???

However, I understand "God's Language"(tm) is not currently understood well
enough by the kernel developers for any of them to translate the kernel
messages into it...

 > {/Satire}

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.471 / Virus Database: 269 - Release Date: 10-Apr-2003


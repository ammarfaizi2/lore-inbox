Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWHRJvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWHRJvw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWHRJvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:51:52 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:58382 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1750761AbWHRJvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:51:51 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: GPL Violation?
Date: Fri, 18 Aug 2006 02:51:13 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEMKNNAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
In-Reply-To: <200608170242.40969.diablod3@gmail.com>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 18 Aug 2006 02:46:09 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 18 Aug 2006 02:46:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Combined responses.

> They don't have to release source code for any module you wrote
> from scratch
> themselves, but said modules cannot say they are GPL (ie, they
> have to poison
> the kernel).

	Nonsense! You absolutely positively can lie about copyright (and even take
what would otherwise be protected by copyright) if the copyright notice or
statement itself is functional.

	Otherwise, for example, a printer by Lexmark could require a poem with the
words 'Copyright, Lexmark Inc.' at the end to be in a chip in the printer
cartridge and refuse to work if it wasn't there. This would, if enforceable,
prevent anyone from making compatible cartridges.

	The GPL notices that the Linux kernel uses to decide whether to taint or
allow access to GPL'd symbols are functional. The GPL prohibits the Linux
kernel from containing any license enforcement schemes (so do not even try
to argue that this is circumventing a license enforcement scheme). Which GPL
provision is being enforced?!

	This is also true under the doctrine of scenes a faire, which basically
says, "when specific instructions are the only and essential means of
accomplishing a given task, their later use by another will not amount to
infringement" so if claiming you are GPL'd is the only way to accomplish a
given task (such as loading a module without poisoning the kernel), you
cannot use copyright to prevent the use of the instructions. (Similarly, if
taking the Linux kernel headers is the only practical way to make a Linux
kernel module, you can do so. Copyright does not cover the only way to
express an idea.)

	IANAL. You should consult one if this matters to you in any significant
way.

	Another caveat: If you need to access symbols marked GPL_ONLY, it is quite
likely that your module is in fact a derived work from the Linux kernel (as
it will contain details of its internals and not work without it). So you
wouldn't be able to distribute it without complying with the GPL anyway.
(There are legal arguments around this, mostly scenes a faire again, but you
would probably be quite foolish to rely on them as they are untested,
AFAIK.)

>It seems like the two issues that need to be addressed are:
>1) Are the kernel modules being developed derived works?  If they are,
>they must be released along with the entire kernel source.
>2) If they are not derived works, and shipped in a product, does the
>fact that they are shipped in a product that uses the linux kernel
>require that the new modules be licensed under the GPL?

	To 2, the answer is (I think) definitely no if you don't link anything
together on the medium, probably no if you do. It is my position that any
non-creative combination process is legally equivalent to mere aggregation,
with only a few specific exceptions set by statute. That is, linking two
works together does not create "a work" but two works that are linked
together. Therefore, it cannot create a derivative work, but two works each
with their own license. (Just like an ISO file of a CD with both GPL'd and
BSD-licensed code on it.)

	To 1, the answer is that it's very hard to tell. My opinion is that it
almost definitely is notm assuming it doesn't include code taken from the
Linux kernel that isn't reasonably necessary to accomplish its function.

	However, I strongly suggest that you try to convince the powers that be
that are they looking at this totally the wrong way. I don't know their
circumstances in enough detail to help you, but in many cases, releasing
more is more sensible than releasing less. Some of the benefits include more
value to the purchaser, the purchaser can contribute improvements back, the
purchaser can maintain the code. Goodwill is huge too. Also, there are a lot
of people on this list whose recommendation of your product may well hinge
on whether you are seen as predatory or cooperative.

	If your company is not very well-known and your product is expensive,
knowing that I can maintain your product yourself may mean the difference
between being willing to pay for it and not willing to risk obsolesence. If
the product is at all aimed at experimenters, having the driver code makes
much more experimentation possible, increasing the value of your product.

	Depending on the circumstances, many more such arguments may be made.

>However, the only valid license under which to distribute the Linux kernel
>is GPL. If the GPL prohibits linking in non-GPL code, and Linux adds no
>exception, then one clearly has no license to distribute Linux if they
>distribute it alongside code that links in to Linux and does not carry the
>GPL license.

	The GPL cannot set its own scope and here you ask it to do just that. If
the GPL could specify how you could *use* covered works, then I could drop a
million copies of a poem from an airplane with a license that said anyone
had to pay me $25 if they read it.

>Both are fairly clear examples of GPL violations. The manufacturer has
>_not_ granted you the freedom to copy, modify and distribute all the
>Linux-based code in the device, as is required by the GPL.

	Again, it doesn't matter what the GPL requires when the question is what is
or is not covered by the GPL. The GPL cannot set its own scope. The device
is not a work, it's an aggregation of multiple works and nothing requires
(or could require) they all be under the same license.

	DS



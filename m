Return-Path: <linux-kernel-owner+w=401wt.eu-S1030280AbWLTTO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWLTTO1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbWLTTO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:14:27 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:4290 "EHLO
	mail1.webmaster.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030280AbWLTTO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:14:26 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: GPL only modules
Date: Wed, 20 Dec 2006 11:14:03 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEKNAHAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.64.0612181839460.20138@iabervon.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 20 Dec 2006 12:17:09 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 20 Dec 2006 12:17:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Note: Combined responses.

> I'd agree that "ar", like "mkisofs", doesn't create a derived work, but I
> think that "objcopy" does create a derived work, and "ld" does too, by
> virtue of modifying the objects it takes to resolve symbols. Now, you
> could distribute to somebody an ar archive of your program, and the
> recipient (given fair use rights to the copy of the program they
> received)
> could do "gcc program.a -o program" to link it. But I don't think you
> automatically get the right (under the "mere aggregation" permission) to
> distribute the result of relocating the symbols of gnutls around those of
> your program and vice versa, along with modifying the references to
> external symbols from each of these to point to specific locations.

The question is, as a matter of copyright law, what right do you need to
distribute the aggregate? As I understand the law, the answer is that you
need the right to distribute each of the individual works in the aggregate.
Fortunately, you can trivially get the right to distribute any GPL'd work
under first sale. (Simply download as many copies as you plan to
distribute.)

To argue otherwise would be to argue that you can't buy a DVD and a Hallmark
card and ship the two of them together to your mother.

--

>This is an interesting argument that was new to me. However, it is not
>clear at all that First Sale applies to intangible copies. And it's
>not clear that there is a sale involved, legally. Again, IANAL, but I
>think this is seriously untested ground.

First sale has nothing do with a sale. 17 USC 109(a) says, "Notwithstanding
the provisions of section 106 (3), the owner of a particular copy or
phonorecord lawfully made under this title, or any person authorized by such
owner, is entitled, without the authority of the copyright owner, to sell or
otherwise dispose of the possession of that copy or phonorecord."

I think it's well settled law that everyone who lawfully acquires a copy of
a copyrighted work has the right to its normal expected use and may transfer
that right along with their copy to another without needing any special
permission from the copyright holder. Exceptions would include cases where
there was specific assent to a license, such as shrink-wrap, click-through,
or EULA.

I'm not really qualified to respond to the argument that first sale doesn't
apply to an intangible copy. As the law is written, it simply refers to the
owner of a "a particular copy". Sometimes "a copy" only means tangible
copies and sometimes it simply means the result of copying. It seems bizarre
to me, however, to argue that if I lawfully download a program, I need
special permission from the copyright holder to put it on CD but not a hard
drive. What is the *legal* difference? And if I put it no a hard drive, I
can't sell it? Seems crazy to me.

--

>AFAIK it's perfectly legitimate (even if immoral) for a copyright
>license to prohibit the distribution of the software governed by the
>license with anything else the author establishes.  E.g., some Java
>virtual machine's license used to establish that you couldn't ship it
>along with other implementations of Java that didn't pass some
>comformance test.

Nobody ever said a copyright holder couldn't restrict the distribution of
his software when such distribution is not authorized by things like fair
use, first sale, or other things. Of course a copyright holder can set any
rules he want for those distributions not authorized by law.

However, those restrictions do not affect those who did not agree to them.
For example, if I buy such a JVM and don't agree to the license (assuming I
don't have to agree to the license to lawfully acquire the JVM), I can give
it to a friend along with any other software I want.

--

>A bare license probably cannot take them away, since you haven't
>agreed to anything.  But (1) that may not be true in all legal
>systems, and (2) a contract-based license can take it away (e.g. an
>NDA).  So the GPL's clarification is worthwhile.  For the same reason,
>I'm guessing, the Creative Commons licenses have (also in section 2,
>at least in v2.5):

The clarification serves another important purpose as well. If some
provision is ambiguous and admits of two readins, one which conflicts with
fair use and would not be enforceable and one which doesn't that is, these
disclaimers make clear that the latter interpretation is the one that should
be chosen. So they may actually *increase* the scope of the license.

DS



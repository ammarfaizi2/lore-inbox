Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbTH2ArN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 20:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTH2ArN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 20:47:13 -0400
Received: from mail.webmaster.com ([216.152.64.131]:32916 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261379AbTH2ArK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 20:47:10 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Bernd Eckenfels" <ecki@calista.eckenfels.6bone.ka-ip.net>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Lockless file reading
Date: Thu, 28 Aug 2003 17:47:04 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEHHFMAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <E19sUzl-0004Az-00@calista.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In article <MDEHLPKNGKAHNMBLJOLKEEEEFMAA.davids@webmaster.com> you wrote:

> > Find those GIFs, double-check, and publish immediately.
> > That would be
> > amazingly big news and would probably cause huge numbers of
> > people to switch
> > from MD5 to SHA1 overnight.

> Why is that?

	Because the security of a hash is based upon it being impractical to find
collisions. If you could demonstrate that you could find even a single
collision (by actually doing it), that would reduce confidence in MD5
massively.

> For a hash with n bits there are at least
> 2^y / 2^n = 2^(y-n) files with the same hash, if they have size y bits.
> Three are even more, if you consider all files up to this size.
>
> With n=128 (md5) and y=80000 (10k file) x=2^79872 different files
> with the same
> hash, which is:
[snip]

	So what? You can, in principle, break a 4096-bit RSA key just by brute
force factorization. The security is based upon the difficulty of actually
doing it in practice. The simplicity of doing it in theory is irrelevent.
Yes, in theory you can break any public key encryption scheme or any hash
digest algrithm by brute force trial and error. In practice, however your
children's, children's, children's, children would be long dead before you
got 1% of the way there.

	To date, no full MD5 collisions have been published and until earlier in
this thread, nobody even claimed to have one. And I'll bet $100 to $1 that
the claimant is in error, either because he used only part of the hash or a
hash of the hash, mis-implementing the hash, o actually hashed the same data
twice without realizing it.

	DS



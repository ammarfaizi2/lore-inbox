Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbUKIRjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbUKIRjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 12:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbUKIRjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 12:39:36 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:37388 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261595AbUKIRjK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 12:39:10 -0500
To: "Clayton Weaver" <cgweav@email.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: support of older compilers
References: <20041106090709.396FA1CE305@ws1-6.us4.outblaze.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: ed  ::  20-megaton hydrogen bomb : firecracker
Date: Tue, 09 Nov 2004 17:39:00 +0000
In-Reply-To: <20041106090709.396FA1CE305@ws1-6.us4.outblaze.com> (Clayton
 Weaver's message of "6 Nov 2004 09:09:32 -0000")
Message-ID: <87zn1qvs5n.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Nov 2004, Clayton Weaver stated:
>>You found a compiler bug, so you reported
>>it as a bug against
>>glibc?
> 
> You don't think it's possible that a glibc bug
> could cause unexpected behavior in a gcc that is
> using the glibc libraries?

Naturally it is; it's even fairly common if you're using a very old
compiler or a very old glibc (although support for libc5 is gone as of
GCC-3.4.)

> I don't know whether glibc-2.3.2 *really*
> had the bug or whether gcc-2.95.3 had some
> dodgy workaround for a bug in earlier glibc2
> versions that fixing a bug in glibc-2.3.2
> then exposed.

That's unlikely.

I just doubt that a bug in string concatenation could be chalked up to
glibc, is all.

> So users arrive at a relatively stable compiler, they stop upgrading
> and use that.

They're of course free to do that, if they don't mind not getting access
to new stuff in the new releases; at least if they're working in C
(anyone compiling C++ code with GCC<3.x is a little strange, in my
opinion).

-- 
`Random line noise picked up from an RS432 cable hung in front of a faulty
 radar transmitter. ' --- Greg Hennessy on sendmail.cf

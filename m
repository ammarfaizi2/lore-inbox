Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUCVPkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 10:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbUCVPkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 10:40:43 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:41940 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262019AbUCVPkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 10:40:40 -0500
Date: Mon, 22 Mar 2004 07:40:34 -0800 (PST)
From: Tigran Aivazian <tigran@veritas.com>
To: Timothy Miller <miller@techsource.com>
cc: David Schwartz <davids@webmaster.com>, Justin Piszcz <jpiszcz@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Microcode Question
In-Reply-To: <405F0B8D.8040408@techsource.com>
Message-ID: <Pine.GSO.4.58.0403220736480.8694@south.veritas.com>
References: <Pine.LNX.4.44.0403191721110.3892-100000@einstein.homenet> 
    <405F0B8D.8040408@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Timothy Miller wrote:
> I don't see anything wrong with what he said.  As I understand it,
> Pentium 4 CPUs don't use microcode for much of anything.  If an
> instruction which was done entirely in dedicated hardware was buggy, and
> it's replaced by microcode, then it will most certainly be slower.
>
> You seem to have missed where David used terms like "theoretically
> possible" and "an operation".

No, that is not what he said and that (what you say) is certainly wrong,
namely this bit:

  If an instruction which was done entirely in dedicated hardware was
  buggy, and it's replaced by microcode, then it will most certainly be
  slower.

All instructions are done by means of microcode of some sort, i.e. the
instructions are "compiled" as they are executed into a more primitive
instruction set (called "microcode" or "u-code"). If a buggy instruction
(or rather the sequence of microcode which corresponds to it) is replaced
by a fixed version (i.e. by some other sequence of microcode) then there
is no reason to say that the result will "most certainly be slower". For
some bugs the fix runs faster than the broken code, for others it may be
slower --- there is no way to tell apriori that it will always be slower.

Do you understand now?

Kind regards
Tigran

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267955AbTBMCK2>; Wed, 12 Feb 2003 21:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267957AbTBMCK2>; Wed, 12 Feb 2003 21:10:28 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:23424 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S267955AbTBMCK0>; Wed, 12 Feb 2003 21:10:26 -0500
Date: Thu, 13 Feb 2003 02:21:27 +0000
From: Jamie Lokier <jamie@shareable.org>
To: David Schwartz <davids@webmaster.com>
Cc: cfriesen@nortelnetworks.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Monta Vista software license terms
Message-ID: <20030213022127.GB13897@bjl1.jlokier.co.uk>
References: <3E4A6917.2030307@nortelnetworks.com> <20030212201840.AAA15967@shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212201840.AAA15967@shell.webmaster.com@whenever>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> 	1) I have all the rights to the difference between the original work 
> and the derived work. (Since I made the derived work, I must.)

The logic of derivation does not work like that.
You don't have all the rights to the difference.

It is not a case of B = C - A.  People do not own individual lines or
bytes of the source code.  (Sometimes they do, but often they don't).

The "difference" between the original work and the derived work is
_itself_ a derived work, because you can't possibly *create* a diff
without deriving from the original work.

In the act of you creating the diff you must have worked from the
original GPL'd work, so the diff is derived from that, as well as from
your original work.  When you write "diff -ur orig-kernel my-kernel
>file", the output from that command is a derived work of the
orig-kernel directory.

This is true even if you didn't copy any context lines from the
original tree.

That means your difference is covered by the GPL, even though you
wrote the changes.

(If you did manage to write the same diff working from other sources,
or if the diff only makes "fair use" of the original, that would be
different.  But any large, complex diff such as a patch to the Linux
VM simply cannot be written without starting from the original Linux VM
code.  It is a question of how well the glove fits the hand, as it were).

(If the difference was just whole files using a well defined
interface, such as a device driver or filesystem, your point seems
quite applicable though.)

-- Jamie

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbTK3Aiq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 19:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbTK3Aip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 19:38:45 -0500
Received: from zork.zork.net ([64.81.246.102]:23974 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264586AbTK3Aio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 19:38:44 -0500
To: linux-kernel@vger.kernel.org
Subject: [OT] Re: Rootfs mounted from user space - problem with umount
References: <3FC82D8F.9030100@undead.cc>
	<20031129053128.GF8039@holomorphy.com> <3FC8394A.7010702@undead.cc>
	<20031129062136.GH8039@holomorphy.com> <3FC869A3.8070809@undead.cc>
	<20031129094435.GS14258@holomorphy.com> <3FC8FB58.6080708@undead.cc>
	<3FC8FF94.3040106@undead.cc> <20031129202559.GJ8039@holomorphy.com>
	<3FC90A2B.9030704@undead.cc> <6ud6baoox6.fsf@zork.zork.net>
	<3FC912D5.7030705@undead.cc>
Reply-To: Sean Neakums <sneakums@zork.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 30 Nov 2003 00:38:42 +0000
In-Reply-To: <3FC912D5.7030705@undead.cc> (John Zielinski's message of "Sat,
 29 Nov 2003 16:42:45 -0500")
Message-ID: <6u8ylyofl9.fsf_-_@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Zielinski <grim@undead.cc> writes:

> Sean Neakums wrote:
>
>>I don't think so; it's mangled here in Gnus, too.
>
> Can you check the message source or save the mail to your HD and see
> if it's mangled there as well?  The lines that cause the problems have
> an extra space at the end of them.   But that's how the were in my
> original patch file.  I forwarded that message to myself and checked
> that actual file on my mail server and the patch was 100% like the
> original.  It _is_ a display bug.

You're right, the patch looks fine in the raw message.  However, the
message's Content-Type header specifies "format=flowed", and according
to RFC 2646, if a line ends in one or more spaces, it is to be flowed
(sec 4.2, paragraph 3).  So it is not a display bug.


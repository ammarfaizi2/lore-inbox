Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267832AbUHER52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267832AbUHER52 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267847AbUHER51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:57:27 -0400
Received: from main.gmane.org ([80.91.224.249]:29855 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267832AbUHERuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:50:51 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: Linux 2.6.8-rc3 - BSD licensing
Date: Thu, 05 Aug 2004 19:45:14 +0200
Message-ID: <yw1x7jsdh42d.fsf@kth.se>
References: <Xine.LNX.4.44.0408041156310.9291-100000@dhcp83-76.boston.redhat.com> <1091644663.21675.51.camel@ghanima>
 <Pine.LNX.4.58.0408041146070.24588@ppc970.osdl.org>
 <1091647612.24215.12.camel@ghanima>
 <Pine.LNX.4.58.0408041251060.24588@ppc970.osdl.org>
 <411228FF.485E4D07@users.sourceforge.net>
 <Pine.LNX.4.58.0408050941590.24588@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 161.80-203-29.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:WA+htvztbgoYOWKHpgoziY7pN98=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 5 Aug 2004, Jari Ruusu wrote:
>> 
>> Most of the files in loop-AES are licensed under GPL. Some files
>> have less restrictive license, but are still licensed under
>> GPL-compatible license.  I am not aware of any files in loop-AES
>> that are GPL-incompatible.
>
> You're saying that you consider Gladman's original AES license to be
> GPL-compatible (ie a subset of it)? That's fine - apparently the FSF
> agrees.
>
> However, that is incompatible with you then complaining when it gets 
> released under the GPL. If the original license was a proper subset of the 
> GPL, then it can _always_ be re-released under the GPL, and you don't have 
> anything to complain about.
>
> So which is it? Either it's GPL-compatible or it isn't. If it is
> GPL-compatible, why are you making noises? And if it is not, why are you
> claiming that you can distribute loop-AES as a GPL'd project?
>
> You seem to be very very confused, Jari. There really _are_ only these two 
> cases:
>
>  - the AES code is GPL-compatible
>
>    This fundamentally means that it has no more restrictions than the GPL, 
>    and that in turn means that it can always be re-licensed as GPL'd code. 
>    Which James Morris did (well, it was dual-licensed, but the only 
>    license that matters for the _kernel_ is the GPL).
>
>    In this case, you can't say "you can't do that". I'm sorry, but James 
>    _can_ do that, and it is _you_ who can't do that. 
>
>  - the AES code is _not_ GPL compatible.
>
>    This fundamentally means that you can't relicense it under the GPL, but 
>    it _also_ means that you can't link it with GPL code, since the GPL
>    _requires_ that the code be under the GPL. In this case, loop-AES was 
>    always wrogn and lying about beign GPL'd, and you should stop
>    distributing it immediately.
>
> You can't have it both ways. And there aren't any third alternatives.

I can think of one more:

Assuming that the AES code is not in itself considered derived from
the kernel, I see nothing preventing the source file in the kernel
tree carrying a BSD license.  Obviously, when used with the kernel the
GPL will apply, but anyone would be free to take the AES code and
reuse it under the BSD license.  If, on the other hand, the AES source
in the kernel only carries a GPL license tag, someone looking at it
will not be aware that the code is (possibly) available with less
restrictions form another source.

Anyone who has as a goal to see the GPL cover all code on the planet
will obviously prefer placing the file under the GPL only wherever he
can.  Legally, though, there should be nothing prohibiting a single
file in the Linux tree with a more permissive license.

IANAL, so please correct me if I am fundamentally wrong somewhere.

-- 
Måns Rullgård
mru@kth.se


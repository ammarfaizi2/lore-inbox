Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbUACVvI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 16:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbUACVvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 16:51:08 -0500
Received: from mx2.midmaine.com ([66.252.32.99]:12941 "HELO mail.midmaine.com")
	by vger.kernel.org with SMTP id S263834AbUACVvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 16:51:05 -0500
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, <netfilter@lists.netfilter.org>
Subject: Re: Three kernel Oops/panic/BUG ksymoopses (kernel BUG at
 buffer.c:539)
X-Eric-Conspiracy: There Is No Conspiracy
References: <Pine.LNX.4.44.0401031352040.2301-100000@poirot.grange>
From: Erik Bourget <erik@midmaine.com>
Date: Sat, 03 Jan 2004 16:50:33 -0500
In-Reply-To: <Pine.LNX.4.44.0401031352040.2301-100000@poirot.grange> (Guennadi
 Liakhovetski's message of "Sat, 3 Jan 2004 13:54:27 +0100 (CET)")
Message-ID: <87ekugzopi.fsf@midmaine.com>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:

> On Fri, 2 Jan 2004, Erik Bourget wrote:
>
>> I had a very bizarre situation where four boxes in the same rack all
>> simultaneously (within 30 minutes) hard-locked with Oops messages.  The
>> boxes
>
> An obvious idea - after reading an article about a break-in into Debian
> and others' boxes - sure you weren't cracked?

Yeah, that was a concern and I'm relatively sure that's not the case because

*) chkrootkit says so (mod some hidden processes that are reported by a bug in
 chkrootkit according to Google)

*) The crashy boxes were all installed with 2.4.23, not upgraded, so the big
 Debian vulnerability didn't exist

*) The only open ports to the outside world are running SMTP and POP3 as
 non-root no-shell accounts, and it's running qmail which seems simple and
 safe enough.

- Erik Bourget


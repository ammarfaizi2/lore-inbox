Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264522AbUFSScE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUFSScE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 14:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbUFSScE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 14:32:04 -0400
Received: from [213.146.154.40] ([213.146.154.40]:49872 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264609AbUFSSbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 14:31:43 -0400
Subject: Re: more files with licenses that aren't GPL-compatible
From: David Woodhouse <dwmw2@infradead.org>
To: Martin Diehl <lists@mdiehl.de>
Cc: Christoph Hellwig <hch@infradead.org>, Oliver Neukum <oliver@neukum.org>,
       davids@webmaster.com, erikharrison@gmail.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0406171201100.7337-100000@notebook.home.mdiehl.de>
References: <Pine.LNX.4.44.0406171201100.7337-100000@notebook.home.mdiehl.de>
Content-Type: text/plain
Date: Sat, 19 Jun 2004 19:29:09 +0100
Message-Id: <1087669749.4230.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-17 at 12:09 +0200, Martin Diehl wrote:
> From a technical point of view I'm just wondering how it comes this 
> firmware is derived from the Linux kernel? I mean this is running on an 
> 8-bit microcontroller with some 4KiB of memory so it sounds pretty much 
> impossible to me.

I'm not sure that the point of your question is. It's _obviously_ not
derived from the Linux kernel; it can be reasonably considered an
independent and separate work in itself. This is part of what the GPL
has to say about such things:

	"These requirements apply to the modified work as a whole.  If
	identifiable sections of that work are not derived from the
	Program, and can be reasonably considered independent and
	separate works in themselves, then this License, and its terms,
	do not apply to those sections when you distribute them as
	separate works.

Unfortunately, you seem to have stopped reading there. You should have
read the rest of the paragraph, and also the following paragraph:

	"            ... But when you distribute the same sections as
	part of a whole	which is a work based on the Program, the
	distribution of the whole must be on the terms of this License,
	whose permissions for other licensees extend to the entire
	whole, and thus to each	and every part regardless of who wrote
	it.

	"Thus, it is not the intent of this section to claim rights or
	contest your rights to work written entirely by you; rather, the
	intent is to exercise the right to control the distribution of
	derivative or collective works based on the Program."

Note the use of the phrase 'derivative OR COLLECTIVE works'. Please
don't confuse the issue by talking only about derivation, when that's
not all that's relevant in the context of the GPL.

To pick another example -- the binary-only module distributed by
Linksys/Cisco in their wireless router products is of dubious legality
by itself since it may or may not be a derived work -- but that's not
really relevant when it's distributed in their product's firmware as
part of a collective work which is based on the Linux kernel. In that
situation it's clearly a copyright violation.

-- 
dwmw2


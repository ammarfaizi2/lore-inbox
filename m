Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbUCKQod (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 11:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUCKQod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 11:44:33 -0500
Received: from topaz.cx ([66.220.6.227]:13762 "EHLO mail.topaz.cx")
	by vger.kernel.org with ESMTP id S261526AbUCKQo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 11:44:27 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: (0 == foo), rather than (foo == 0)
X-Newsgroups: linux.kernel
In-Reply-To: <1ypPV-5N2-3@gated-at.bofh.it>
From: chip@pobox.com (Chip Salzenberg)
Organization: NASA Calendar Research
Message-Id: <E1B1TIJ-0007Tm-Jn@tytlal>
Date: Thu, 11 Mar 2004 11:44:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amarendra.Godbole@ge.com writes:
>> As a result, using the former just tends to increase peoples 
>> confusion by making code harder to read, which in turn tends 
>> to increase the chance of bugs.
>
>Kindly don't insult the kernel developers' with such statements. ;-)
>They are smart enough to understand such constructs [...]

It's not about intelligence!  It's about the nature of human visual
pattern-matching.  Reading a pattern is always easier when you've seen
it thousands of times before.

Henry Spencer's dictum about brace style seems particularly apropos:

8.  Thou shalt make thy program's purpose and structure clear to thy
    fellow man by using the One True Brace Style, even if thou likest
    it not, for thy creativity is better used in solving problems than
    in creating beautiful new impediments to understanding.

And that's what "0 == foo" is: an impediment to understanding.
-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWGOVJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWGOVJa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 17:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWGOVJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 17:09:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:46536 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161027AbWGOVJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 17:09:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MoQdpse+S1FCuMrq8qaN4fMpEhP4+fgirr25nOF+Tp629ST/wEtE5OtFlc+JVRNjf9Jy3PmXllGnDNLuN3OaQtnR3DwmMuiGeRN1pdimtQOqXdYytuyrOzyG/YDj1hE3eEy0hSUMTEsSEX5kjpE3+aPFGNdzoTtKnqG9AoKFBS0=
Message-ID: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
Date: Sat, 15 Jul 2006 17:09:28 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: dwmw2@infradead.org, arjan@infradead.org, maillist@jg555.com,
       ralf@linux-mips.org, linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: 2.6.18 Headers - Long
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:

> Kernel headers are _not_ a library of random crap for userspace to use.

The attraction is that the kernel abstractions are very nice.
Much of the POSIX API sucks ass. The kernel stuff is NOT crap.

Here we have a full-featured set of atomic ops, byte swapping
with readable names and a distinction for pointers, nice macros
for efficient data structure manipulation...

Sure, you'd like all the app developers to write bloated C++
and use sucky POSIX threads stuff, but then you're not the
one who has to write or maintain it.

Don't blame app developers if they go for what is good.
To stop them, provide the goodness in a sane way.
(alternately, make the Linux code suck ass more than POSIX)

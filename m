Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266425AbUGBD1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbUGBD1O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 23:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266431AbUGBD1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 23:27:14 -0400
Received: from hiauly1.hia.nrc.ca ([132.246.100.193]:12295 "EHLO
	hiauly1.hia.nrc.ca") by vger.kernel.org with ESMTP id S266425AbUGBD1N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 23:27:13 -0400
Message-Id: <200407020324.i623OIZ9011855@hiauly1.hia.nrc.ca>
Subject: Re: [parisc-linux] Comparing PROT_EXEC-only pages on different CPUs
To: jamie@shareable.org (Jamie Lokier)
Date: Thu, 1 Jul 2004 23:24:17 -0400 (EDT)
From: "John David Anglin" <dave@hiauly1.hia.nrc.ca>
Cc: linux-kernel@vger.kernel.org, davidm@hpl.hp.com, Richard.Curnow@superh.com,
       matthew@wil.cx, lethal@linux-sh.org, ink@jurassic.park.msu.ru,
       linux-ia64@linuxia64.org, rth@twiddle.net,
       linuxsh-shmedia-dev@lists.sourceforge.net,
       parisc-linux@parisc-linux.org
In-Reply-To: <20040701224016.GB7928@mail.shareable.org> from "Jamie Lokier" at Jul 1, 2004 11:40:16 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Richard raises an interesting point: exec-only pages are useless if
> the code needs to read jump tables and constant pools.  It seems very
> likely Alpha and IA64 have these.

HPPA GCC code also needs to be able to read jump tables in .text.

Dave
-- 
J. David Anglin                                  dave.anglin@nrc-cnrc.gc.ca
National Research Council of Canada              (613) 990-0752 (FAX: 952-6602)

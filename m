Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130493AbRDDTAh>; Wed, 4 Apr 2001 15:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131347AbRDDTA1>; Wed, 4 Apr 2001 15:00:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22543 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130493AbRDDTAT>; Wed, 4 Apr 2001 15:00:19 -0400
Subject: Re: mysqld [3.2.23] hangs when key_buffer ~256MB on [2.4.2-ac28+]
To: vhou@khmer.cc (Vibol Hou)
Date: Wed, 4 Apr 2001 20:02:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <NDBBKKONDOBLNCIOPCGHKELLFOAA.vhou@khmer.cc> from "Vibol Hou" at Apr 04, 2001 11:44:00 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ksXc-0002YN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I initially upgraded my kernel from 2.4.2-ac5 to 2.4.3 and the first thing I
> noticed was that mysqld was stuck.  Killing it left it hanging in a D state.
> Then I tried 2.4.2-ac28 (which I am using now), and the got the same result.

I'd expect that bit. 2.4.2-ac28 basically has the same new rwlock VM and
behaviour as 2.4.3pre8. What would be really useful to know is if anyone can
duplicate the problem non x86

> Can anyone reproduce this problem?

Yes

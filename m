Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbTHYG3L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 02:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTHYG3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 02:29:11 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:52612 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261494AbTHYG3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 02:29:09 -0400
Date: Mon, 25 Aug 2003 07:29:05 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jakob Oestergaard <jakob@unthought.net>,
       Jim Houston <jim.houston@comcast.net>, linux-kernel@vger.kernel.org,
       jim.houston@ccur.com
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault
Message-ID: <20030825062905.GA21262@mail.jlokier.co.uk>
References: <1061498486.3072.308.camel@new.localdomain> <20030825040514.GA20529@mail.jlokier.co.uk> <20030825041423.GB29987@unthought.net> <20030825055028.GE20529@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825055028.GE20529@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> So that means the sysenter instruction _does_ exist on the PPro and
> early Pentium II, but it isn't usable.

If anyone has information on what the SYSENTER and SYSEXIT
instructions actually do on Intel Pentium Pro or stepping<3 Pentium II
processors, I am very interested.

I'm intrigued to know if the buggy behaviour of these instructions is
really unsafe, or simply hard to use so Intel changed the behaviour.
(An example of hard to use would be SYSENTER not disabling
interrupts).  If they are safe but hard to use, perhaps the ingenuity
of kernel hackers can work around the hardness >:)

Does anyone have a contact at Intel for this question?

Thanks,
-- Jamie

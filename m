Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132705AbRDIIme>; Mon, 9 Apr 2001 04:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132706AbRDIImY>; Mon, 9 Apr 2001 04:42:24 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:26372 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S132705AbRDIImM>;
	Mon, 9 Apr 2001 04:42:12 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104090842.f398g2f495273@saturn.cs.uml.edu>
Subject: Re: [PATCH] Re: softirq buggy
To: manfred@colorfullife.com (Manfred Spraul)
Date: Mon, 9 Apr 2001 04:42:02 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AD0D9A8.189AA43C@colorfullife.com> from "Manfred Spraul" at Apr 08, 2001 11:35:36 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd prefer to inline cpu_is_idle(), but optimizing the idle
> code path is probably not that important ;-)

Sure it is, in one way: how fast can you get back to work?
(not OK to take a millisecond getting out of the idle loop)

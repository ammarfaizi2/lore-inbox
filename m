Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbTI3IAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 04:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbTI3IAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 04:00:20 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:34502 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261203AbTI3IAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 04:00:18 -0400
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] document optimizing macro for translating PROT_ to VM_
 bits
References: <20030929090629.GF29313@actcom.co.il>
	<20030929153437.GB21798@mail.jlokier.co.uk>
	<20030930071005.GY729@actcom.co.il>
	<buohe2u3f20.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20030930074138.GG729@actcom.co.il>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 30 Sep 2003 16:59:56 +0900
In-Reply-To: <20030930074138.GG729@actcom.co.il>
Message-ID: <buoad8m3dvn.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> writes:
> Ok, that's a pretty convincing argument for scraping that
> version. I'll rewrite it to evaluate the arguments at compile time if
> they're constants, which they are, in our case. Unless someone else
> beats me to it, of course ;-) 

What's wrong with the macro version?  The presence of a __ prefix
suggests that it's only used in controlled circumstances anyway, so is
validity-checking on the bit arguments really worthwhile?

-miles
-- 
The secret to creativity is knowing how to hide your sources.
  --Albert Einstein

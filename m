Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263351AbTJ0Qc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 11:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTJ0Qc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 11:32:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:34507 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263351AbTJ0Qc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 11:32:58 -0500
Date: Mon, 27 Oct 2003 08:32:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: vojtech@suse.cz, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PS/2 mouse rate setting 
In-Reply-To: <20031027140217.GA1065@averell>
Message-ID: <Pine.LNX.4.44.0310270830060.1699-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Oct 2003, Andi Kleen wrote:
> 
> Overall as KVM user I must say I'm not very happy with the 2.6 mouse
> driver. 2.4 pretty much worked out of the box, but 2.6 needs
> lots of strange options (psmouse_noext, psmouse_rate=80) 
> because it does things very differently out of the box.

I agree. The keyboard driver has also deteriorated, I think. 

I'd suggest we _not_ set the rate by default at all (and let the default
thing just happen). And only set the rate if the user _asks_ for it with
your setup thing. Mind sending me that kind of patch?

		Linus


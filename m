Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265231AbUBIOpL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 09:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUBIOpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 09:45:11 -0500
Received: from ns.suse.de ([195.135.220.2]:50154 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265231AbUBIOpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 09:45:08 -0500
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: Does anyone still care about BSD ptys?
References: <c07c67$vrs$1@terminus.zytor.com.suse.lists.linux.kernel>
	<c07i5r$ctq$1@news.cistron.nl.suse.lists.linux.kernel>
	<20040209100940.GF21151@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
	<20040209104729.GA19401@traveler.cistron.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 09 Feb 2004 15:45:06 +0100
In-Reply-To: <20040209104729.GA19401@traveler.cistron.net.suse.lists.linux.kernel>
Message-ID: <p73u120jor1.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg <miquels@cistron.nl> writes:

> 
> Well, nothing really, but removing BSD style support in the 2.6 series
> now will break existing installations. Doing it in 2.7 would be fine.

It will still break existing installations even in 2.7.  And breaking
early user space is especially nasty to recover from.  Somehow I
cannot believe keeping them around for compatibility is a unduly
burden. Please don't remove them.

-Andi

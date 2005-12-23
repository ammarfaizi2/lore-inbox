Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbVLWFM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbVLWFM6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 00:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbVLWFM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 00:12:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:6721 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030412AbVLWFM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 00:12:57 -0500
Date: Fri, 23 Dec 2005 00:12:47 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/8] mutex subsystem, -V6
In-reply-to: <20051222230438.GA13302@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@infradead.org>
Message-id: <Pine.LNX.4.64.0512230005590.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051222230438.GA13302@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2005, Ingo Molnar wrote:

> this is verion -V6 of the generic mutex subsystem.
> 
> Nico, Christoph, does this approach work for you?

OK.  My final request would be for architectures to have the choice 
whether to have the fast path inlined or not.  I have a patch that does 
just that, but it would conflict with Linus' suggestion about the 
debugging stuff if you intend to implement it.


Nicolas

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbTA1V1N>; Tue, 28 Jan 2003 16:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbTA1V1N>; Tue, 28 Jan 2003 16:27:13 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:60434 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261337AbTA1V1M>; Tue, 28 Jan 2003 16:27:12 -0500
Date: Tue, 28 Jan 2003 21:36:31 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Joshua Kwan <joshk@ludicrus.ath.cx>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59: radeonfb, no visible cursor at the fb console
In-Reply-To: <20030128201126.GA25318@ludicrus.ath.cx>
Message-ID: <Pine.LNX.4.44.0301282135090.12076-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why is this different from the block cursor that is seen in 2.4? (this 
> one is a '_' type)

Because '_' is the default cursor for Dec VT100 and VT220 terminals. You 
can easily change it via the console layer. 

> Is it a soft cursor and not the hardware one?

At present it is a software cursor. There is no hardware cursor support 
for the radeon.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267982AbRGXQul>; Tue, 24 Jul 2001 12:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267991AbRGXQub>; Tue, 24 Jul 2001 12:50:31 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:22282 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267982AbRGXQu0>; Tue, 24 Jul 2001 12:50:26 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 24 Jul 2001 09:48:52 -0700
Message-Id: <200107241648.f6OGmqp29445@penguin.transmeta.com>
To: phillips@bonn-fries.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Optimization for use-once pages
Newsgroups: linux.dev.kernel
In-Reply-To: <01072405473005.00301@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hey, this looks _really_ nice. I never liked the special-cases that you
removed (drop_behind in particular), and I have to say that the new code
looks a lot saner, even without your extensive description and timing
analysis.

Please people, test this out extensively - I'd love to integrate it, but
while it looks very sane I'd really like to hear of different peoples
reactions to it under different loads.

		Linus


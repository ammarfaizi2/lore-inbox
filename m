Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130356AbRATFfL>; Sat, 20 Jan 2001 00:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136653AbRATFfB>; Sat, 20 Jan 2001 00:35:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:60170 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130356AbRATFe4>; Sat, 20 Jan 2001 00:34:56 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Coding Style
Date: 19 Jan 2001 21:34:42 -0800
Organization: Transmeta Corporation
Message-ID: <94b81i$2qi$1@penguin.transmeta.com>
In-Reply-To: <3A68809B.E12EF3D9@purplecoder.com> <200101200046.f0K0kgj201065@saturn.cs.uml.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200101200046.f0K0kgj201065@saturn.cs.uml.edu>,
Albert D. Cahalan <acahalan@cs.uml.edu> wrote:
>> Tabs are 8 characters so NO tabs should be used in ANY source file what 
>...
>> Rationale:  Tabs force your code out to the right edge of the display
>> leaving no room for comments.  You don't need great big gaping spaces to
>> delineate the start and end of a block, TWO spaces do this just fine.
>
>Correct, because adjustable tab width is a myth. The comments don't
>line up when you muck with tab width.

Read the Linux CodingStyle.

Tabs are 8 characters. They are NOT adjustable. Never have been, never
will be. Anybody who thinks tabs are anything but 8 chars apart is just
wrong. It's that simple.

And two spaces is not enough. If you write code that needs comments at
the end of a line, your code is crap. It's that easy. There is _never_ a
reason to comment a single line, and multi-line comments the the right
of multi-line code to the left is a recipe for disaster. In short, you
don't do comments to the right of code - you do them _before_ code.

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

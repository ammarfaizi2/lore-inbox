Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317416AbSGTOjX>; Sat, 20 Jul 2002 10:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317418AbSGTOjW>; Sat, 20 Jul 2002 10:39:22 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:169 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S317416AbSGTOjW>;
	Sat, 20 Jul 2002 10:39:22 -0400
Date: Sat, 20 Jul 2002 16:42:17 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Joseph Malicki" <jmalicki@starbak.net>
Cc: "Patrick J. LoPresti" <patl@curl.com>, <linux-kernel@vger.kernel.org>
Subject: Re: close return value
Message-ID: <20020720144217.GA2259@win.tue.nl>
References: <200207182347.g6INlcl47289@saturn.cs.uml.edu> <s5gsn2fr922.fsf@egghead.curl.com> <015401c22f40$c4471380$da5b903f@starbak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015401c22f40$c4471380$da5b903f@starbak.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 12:24:33PM -0400, Joseph Malicki wrote:

> Those mistakes are your ignorance.  The manpage is wrong.
> It does return -1 on error.

Yes, you are right (or, at least, "a negative value").
Now you deserve a beating for noting that there is a bug on
a man page without submitting a correction, or at least
telling the maintainer. (Yes, that's me.)

> Sure, if you require an event to be successful to continue you should always
> check it.  And yes, it's nice to print an error message on close sometimes,
> if something is critical.  But the question to ask is what you would
> actually _DO_ about an error... if the answer is nothing,
> then why check it?

But here you are wrong. Even if the program doesn't know what to do,
the user will want to know about it. If I make a backup and some error
occurs then I would be very unhappy if the program were silent about it.

Andries
aeb@cwi.nl

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUA0GP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 01:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbUA0GP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 01:15:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:23183 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262055AbUA0GP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 01:15:56 -0500
Date: Mon, 26 Jan 2004 22:15:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries.Brouwer@cwi.nl
cc: akpm@osdl.org, gotom@debian.or.jp, linux-kernel@vger.kernel.org
Subject: Re: [uPATCH] refuse plain ufs mount
In-Reply-To: <UTC200401270407.i0R47oi29367.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.58.0401262210050.10794@home.osdl.org>
References: <UTC200401270407.i0R47oi29367.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Jan 2004 Andries.Brouwer@cwi.nl wrote:
> 
> Funny how we alternate - when I choose the pure, theoretical point of view
> you prefer practice, when I prefer practice you become pure.

Heh.

I'm actually usually very easy to predict:

 - when it comes to "core technology" bugs, I'd much rather fix them
   _right_. To the point where I prefer to not fix them at all if the fix
   is only hiding the real bug. Then I'd rather leave it as a known bug
   and hope the _real_ fix comes in.

 - but when it comes to things that are more about "usability", I tend to
   try to take the very practical approach. So we'll disagree on things 
   like "should the kernel autodetect", because I think that's a usability
   issue, and consider that it should be as easy for users as possible.

The reiserfs/ufs issue to me is about "usability", not "core technology".  
As such, to me it falls under the "practical" heading, and the solution
should be the pragmatic trivial "just test reiserfs first" kind of silly
thing.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262886AbUJ1Gv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbUJ1Gv0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbUJ1GuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:50:06 -0400
Received: from mo.optusnet.com.au ([203.10.68.101]:31168 "EHLO
	mo.optusnet.com.au") by vger.kernel.org with ESMTP id S262818AbUJ1Gr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 02:47:59 -0400
To: John Richard Moser <nigelenki@comcast.net>
Cc: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
References: <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin>
	<200410261719.56474.edt@aei.ca>
	<Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt>
	<417F315A.9060906@comcast.net>
From: michael@optusnet.com.au
Date: 28 Oct 2004 16:46:58 +1000
In-Reply-To: <417F315A.9060906@comcast.net>
Message-ID: <m1sm7znxul.fsf@mo.optusnet.com.au>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser <nigelenki@comcast.net> writes:
[ .. lots of stuff .. ]
> Let's make 2.7 what 2.6 is now (a relatively stable kernel that gets
> relatively stable feature enhancements continuously), rather than what
> 2.5 was (a hell of a lot of patches and then a hell of a lot of
> debugging), and make 2.6 more restrictive than 2.4 in that it should be
> strictly bugfixes (including security bugs) and no backported drivers or
> features.

There seems to be a lot of strange notions on this concept of 'stable'.
The only thing that makes a kernel 'stable' is time. Not endless
bugfixes. Just time. The idea of stable software is software that not
going to give you any suprises, software that you can trust.

That's NOT the same as bug free software. For a start, there's no such
thing. For another, many bugs are perfectly acceptable in a production
environment as long as they're not impacting. (The linux kernel is a
very large piece of work. Few installations would use even 20% of the
total kernel functionality).

If you want a stable kernel version, pick one (almost any one will
do). Test the hell of out it with your application(s). If it fails,
fix the bug, or pick a different version. rinse, repeat.

Now you've got a kernel that tests clean with your app. DON'T
CHANGE IT!! 

Ta-Dah! You've got a stable kernel.

Now why would you change it? The only possible reasons
are that your testing was terrible and you missed a bug,
in which case you can go back to step 1, or that you
want a new feature. In which case you can go back to
step 1.

That wasn't too hard, was it. Even better, you didn't see
anything in there about 2.6 v 2.7 or other such fluff.

Michael.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbSCKScg>; Mon, 11 Mar 2002 13:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286825AbSCKSc0>; Mon, 11 Mar 2002 13:32:26 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:526 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S285720AbSCKScV>;
	Mon, 11 Mar 2002 13:32:21 -0500
Date: Sun, 10 Mar 2002 20:28:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Jonathan A. George" <JGeorge@greshamstorage.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
Message-ID: <20020310192848.GA173@elf.ucw.cz>
In-Reply-To: <3C87FD12.8060800@greshamstorage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C87FD12.8060800@greshamstorage.com>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I am considering adding some enhancements to CVS to address deficiencies 
> which adversely affect my productivity.  Since it would obviously be 
> nice to have a completely free (or even GPL :-) tool which is not 
> considered to consist of unacceptable compromises in the process of 
> kernel development I would like to know what the Bitkeeper users 
> consider the minimum acceptable set of improvements that CVS would 
> require for broader acceptance.  Obviously the tremendous set of 
> features that Bitkeeper has are nice, but I'd like to narrow the 
> comparative flaws to a manageable set.

My pet feature?

cvs dontcommit file.c

What it should do? Mark changes in file.c as private to me, so that it
never tries to commit them to official tree. It would be best if cvs
diff just pretended changes are not there.

So, if I checkout tree, do some dirty hacks to make it compile, do cvs
dontcommit ., cvs diff should show nothing and cvs commit should try
to commit nothing. That would be nice,
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

Return-Path: <linux-kernel-owner+w=401wt.eu-S965509AbWLPVBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965509AbWLPVBK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 16:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965512AbWLPVBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 16:01:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44020 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965509AbWLPVBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 16:01:08 -0500
Date: Sat, 16 Dec 2006 13:01:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ricardo Galli <gallir@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <200612161927.13860.gallir@gmail.com>
Message-ID: <Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
References: <200612161927.13860.gallir@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2006, Ricardo Galli wrote:

> As you probably know, the GPL, the FSF, RMS or even GPL "zealots" never tried 
> to change or restrict "fair use". GPL[23] covers only to "distibution" of the 
> covered program. The freedom #0 says explicitly: "right to use the program 
> for any purpose".

I'm sorry, but you're just rewriting history.

The FSF very much _has_ tried to make "fair use" a very restricted issue. 
The whole reason the LGPL exists is that people realized that if they 
don't do something like that, the GPL would have been tried in court, and 
the FSF's position that anything that touches GPL'd code would probably 
have been shown to be bogus.

In reality, if the FSF actually believed in "fair use", they would just 
have admitted that GNU libc could have continued to be under the GPL, and 
that any programs that link against it are obviously not "derived" from 
it.

But no. The FSF has very much tried to confuse and muddle the issue, and 
instead have claimed that projects like glibc should be done under the 
"Lesser" GPL.

That's just idiocy, but it works as a way to defuse the problem that the 
FSF has always had with admitting that not only _they_ have "fair use" 
rights, but others have them too.

Do you REALLY believe that a binary becomes a "derived work" of any random 
library that it gets linked against? If that's not "fair use" of a library 
that implements a standard library definition, I don't know what is.

And yes, the FSF really has tried to push that totally insane argument. 

So don't tell me that the FSF honors "fair use". They say they do, but 
they only seem to honor it when it helps _their_ argument, not when it 
helps "those evil people who try to take advantage of our hard work".

The fact is, if you accept fair use, you have to accept it for other 
people to take advantage of too. Fair use really isn't just a one-way 
street.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965189AbVLVU1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbVLVU1g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 15:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbVLVU1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 15:27:36 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:1255 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965186AbVLVU1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 15:27:34 -0500
Subject: Re: blatant GPL violation of ext2 and reiserfs filesystem drivers
From: Steven Rostedt <rostedt@goodmis.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: legal@lists.gnumonks.org, linux-fsdevel@vger.kernel.org,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       "Robert W. Fuller" <garbageout@sbcglobal.net>
In-Reply-To: <496FC071-3999-4E23-B1A2-1503DCAB65C0@mac.com>
References: <43AACF77.9020206@sbcglobal.net>
	 <496FC071-3999-4E23-B1A2-1503DCAB65C0@mac.com>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 15:27:21 -0500
Message-Id: <1135283241.12761.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 13:01 -0500, Kyle Moffett wrote:
> On Dec 22, 2005, at 11:08, Robert W. Fuller wrote:
> > Please see the following thread:
> >
> > http://www.opensolaris.org/jive/thread.jspa?threadID=2132&tstart=0x
> >
> > Sorry I didn't get around to reporting this sooner, but at least  
> > the guilty party has had plenty of time to fail to repent.
> >
> > Regards,
> >
> > Rob
> 
> This case looks about as black and white as it gets (although IANAL),  
> so I'm adding gpl-violations.org-legal to the CC list.

I'm not sure this is the case here or not, but it definitely brings up
an interesting question.

Since the dynamic loading of binary modules into Linux seems to be a
gray area, since if I give you a binary module that loads into Linux,
but except for the API found in the header files, the module contains no
GPL code. Is it bound to the GPL?  This is a rhetorical question, please
don't answer it.

Now the real question:  If one were to have an operating system, and set
up a layer that simulated the API of Linux, such that Linux binary
modules could be loaded, is _that_ a violation of the GPL?  IOW, one
would only distribute to you a system that has no GPL code, and only
simulates an API, which is legal otherwise Samba wouldn't exist. But the
user has the option of compiling a Linux module to get the benefits from
it.  Sort of a ndiswrapper in reverse!

-- Steve



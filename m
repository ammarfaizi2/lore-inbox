Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEW3B>; Fri, 5 Jan 2001 17:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130027AbRAEW2v>; Fri, 5 Jan 2001 17:28:51 -0500
Received: from 209.102.21.2 ([209.102.21.2]:9481 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S129183AbRAEW2j>;
	Fri, 5 Jan 2001 17:28:39 -0500
Message-ID: <3A561A23.F1B9F198@goingware.com>
Date: Fri, 05 Jan 2001 19:01:55 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-prerelease-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Is your component's config help up-to-date?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to request that if you are responsible for an option that can be
configured in the kernel, that you look at the help for it and make sure it is
currently up to date.

I know that it is more important to the correct function of the kernel that your
software actually be fully implemented and bug-free, but the config help is
often the only thing that a lot of people will know about your part of the
kernel until they've been working with the new system for a while.  At the very
least you'll save yourself answering some questions and looking into bogus bug
reports if you make sure the help is correct.

It's my experience that after a while of testing lots of new kernels I stop
looking at the help much.  Maybe you haven't looked at it very much since you
originally composed it, but the behaviour of your component has changed so that
it no longer matches the description.

This is in the file linux/Documentation/Configure.help (to edit it).  You can of
course also read it by configuring a kernel and checking the help on your
option.

- Are there any questions frequently asked on the mailing list that you could
head off by
  answering them in the config help?

- Is the help written in a clear and unambiguous way?  Have a friend who isn't
an expert 
  read it and tell you what he thinks it means.  Rememember that many people who
will be 
  reading it do not have English as their mother tongue and may even be using a
translation
  dictionary to understand it.

- Does the help describe the current behavior of your option?

- Have you added support for new hardware in a driver that's not yet mentioned
in the help?

- If the behavior depends on the configuration of other options, is the
described behavior
  actually what currently happens when those other options are set various
ways?  I know this
  can take sime time to test out the different options by actually building and
trying out
  the kernels but it's important to head off a bunch of mystified users.

- Does the recommendation that the help gives correspond to your current
thinking?

- Are any URL's or references to external doc given in the help correct?

- Could you add any URL's or references to doc like HOWTOs that would be
helpful?

Yours,

Mike
-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

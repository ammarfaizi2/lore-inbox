Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVCJC1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVCJC1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVCJCZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 21:25:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:36055 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261157AbVCJCYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 21:24:16 -0500
Date: Wed, 9 Mar 2005 18:25:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Omkhar Arasaratnam <iamroot@ca.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, tgall@us.ibm.com,
       antonb@au1.ibm.com, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [BUG] 2.6.11- sym53c8xx Broken on pp64
In-Reply-To: <1110420620.32525.145.camel@gaston>
Message-ID: <Pine.LNX.4.58.0503091821570.2530@ppc970.osdl.org>
References: <422FA817.4060400@ca.ibm.com> <1110420620.32525.145.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Mar 2005, Benjamin Herrenschmidt wrote:
> 
> BTW, Linus: Any chance you ever change something to version or
> extraversion in bk just after a release ? I know I already ask and it
> degenerated into a flamefest, and I don't know if that is specifically
> the case now, but I keep getting report of people saying "I have a bug
> in 2.6.xx" while in fact, they have some kind of bk clone of sometime
> after 2.6.xx...

The answer is the same: I'd still like to have somebody (preferably Sam)  
who is comfortable with all the build scripts get a revision-control-
specific version at build-time, so that BK users would get the top-of-tree 
key value, and other people could get some CVS revision or something.

I don't want to tag things just randomly, especially as it would be very
error-prone (read: I'd forget). A script that looks at the top revision,
and if it's not a tag, takes the key value and appends it to the build
version seems to be The Right Thing (tm). 

I have this dim memory that Sam might even have had some early trials, but 
maybe thats just wishful thinking.. Sam?

		Linus

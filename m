Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWAQUig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWAQUig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWAQUig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:38:36 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:12977 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964824AbWAQUie convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:38:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZQym+lfrBxQHymKoDOs6m+ptd0vkuHONJlm+I9HynOMbB2qacLyFhKBNR7TXC2ZDxwKR6eXaZC4qmn0BwcclGcfN5L3LCjdlNOlLFqHUveGOXa9E/LUHWsQ4jpI1mTrR4e8/Vo0/A08EE3AVIoPmP7tYPhx33UqcU/Cl+TGf/TU=
Message-ID: <9a8748490601171238y12be9933ha8068985cf2a1cbf@mail.gmail.com>
Date: Tue, 17 Jan 2006 21:38:33 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Per Liden <per.liden@ericsson.com>
Subject: Re: [PATCH] TIPC: add Kconfig help text
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jon Maloy <jon.maloy@ericsson.com>,
       Allan Stephens <allan.stephens@windriver.com>,
       tipc-discussion@lists.sourceforge.net
In-Reply-To: <9a8748490601171224q15d1b8e9n23706782c85f26d7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601172058.31503.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0601172105180.17253@ulinpc219.uab.ericsson.se>
	 <9a8748490601171224q15d1b8e9n23706782c85f26d7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 1/17/06, Per Liden <per.liden@ericsson.com> wrote:
> > I've already committed a patch similar to this in our GIT repo
> > (http://tipc.cslab.ericsson.net), just haven't asked for it to be pulled
> > yet since we have another fix for some namespace pullution in the
> > pipeline. Thanks though!
> >
>
> Good enough for me :-)
>

Let me just pick another little nit here.

Your entries in the MAINTAINERS file for TIPC;
Would it be too much to ask that you list the *correct* email
addresses for people in there instead of the @nospam.ericsson.com
obfuscated ones?

As I see it, listing the obfuscated addresses buys you nothing, since
you are using the real address to post to a public (and widely
archived) mailing list anyway, and has a few real drawbacks:

- some users (especially users who are not native english speakers)
may not realize that the "nospam." bit should be taken out and thus
you may miss emails.

- it adds extra work (small, but still) on everyone who looks up the
maintainer for TIPC to send you guys emails to parse the addr and
realize the addr needs to be edited and then actually edit it instead
of just cut'n'paste.

- it's somewhat annoying.


I even opted to send the patch to both the @nospam.ericsson.com and
@ericsson.com addresses since I didn't know if "nospam." was to be
taken out or if it was just some subdomain you used specifically for
communication on public lists that you then did extra SPAM filtering
on - there's no way to know.
If you are worried about getting extra SPAM by being listed in
MAINTAINERS, why don't you just create an extra email alias that you
list in MAINTAINERS and use for LKML stuff - that alias you can then
do extra filtering on, dump in a seperate mailbox/folder/whatever... I
don't think you actually gain anything by your current scheeme.

I'll stop ranting now ;)

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

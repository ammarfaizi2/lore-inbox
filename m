Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263120AbVGOBpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbVGOBpb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 21:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbVGOBpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 21:45:31 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:18498 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263120AbVGOBp3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 21:45:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dyN2rAtoJx2axyS3MpT7c+bVkO4p4lKqZVz2qAHfxh0l2X3Qp2d/ly0ANndkjbyPr7Xz2mZHXUrq7HWchUmy/feYQY0gMYKMVUN2XZEfy9VGBx3+VDG5GUBxt5JaTq5lFqZzEevS5dreHYfkfwVCAgGI1BIKAd6eDJdGFiN7SnA=
Message-ID: <9a8748490507141845162c0f19@mail.gmail.com>
Date: Fri, 15 Jul 2005 03:45:28 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
Cc: Mark Gross <mgross@linux.intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <p73wtnsx5r1.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel>
	 <p73wtnsx5r1.fsf@bragg.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jul 2005 02:38:58 +0200, Andi Kleen <ak@suse.de> wrote:
> Mark Gross <mgross@linux.intel.com> writes:
> >
> > The problem is the process, not than the code.
> > * The issues are too much ad-hock code flux without enough disciplined/formal
> > regression testing and review.
> 
> It's basically impossible to regression test swsusp except to release it.
> Its success or failure depends on exactly the driver combination/platform/BIOS
> version etc.  e.g. all drivers have to cooperate and the particular
> bugs in your BIOS need to be worked around etc. Since that is quite fragile
> regressions are common.
> 
> However in some other cases I agree some more regression testing
> before release would be nice. But that's not how Linux works.  Linux
> does regression testing after release.
> 
And who says that couldn't change?

In my oppinion it would be nice if Linus/Andrew had some basic
regression tests they could run on kernels before releasing them.
There are plenty of "Linux test" projects out there that could be
borrowed from to create some sort of regression test harness for them
to run prior to release.   It would be super nice if they had a suite
of tests to run and could then drop a mail on lkml saying 2.6.x is
almost ready to go, but it currently fails regression tests #x, #y &
#z, we need to get those fixed first before we can release this - and
then every time a bug was found that could resonably be tested for in
the future it would be added to the regression test suite...  That
would lead to more consistent quality I believe.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVGSBZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVGSBZc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 21:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVGSBZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 21:25:32 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:16651 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261828AbVGSBZa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 21:25:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ADO5H3PtEiJLRymnVB6UoQPOAI3IFZzW9Y0aZIxYpjSSWjJ7zrNGWJOrVR8D0Pa7wJ91qkf2znahOsmeXua2FI0QdpHJDHggfR3VyHF30z5z3MgYwc0H3SU4bHtyVWrL3bvRVL+S5zvhrZ4a479e+HGtGqY0VPdJmLsuXy1N/6E=
Message-ID: <9a8748490507181824432e498b@mail.gmail.com>
Date: Tue, 19 Jul 2005 03:24:59 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: regatta <regatta@gmail.com>
Subject: Re: how to be a kernel developer ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a87484905071818116f7cb0de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a3ed56505071807357fc419e7@mail.gmail.com>
	 <9a87484905071818116f7cb0de@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 7/18/05, regatta <regatta@gmail.com> wrote:
> > Hi
> >
> > I want to join the Kernel community and help in developing Linux
> > kernel, I'm good in C,Perl and  not that good in C++
> >
> The kernel is written in (mainly) C and (a little bit of) asm, no C++ in there.
> 
> > is there any How-To page in how to help or how to join ? since I want
> > to start in basic things
> >
> A few things you should do :
> 
[snip]

A few things I forgot to mention in the first mail.

You can also help out by testing the development kernels - they need
testing by as many people as possible, so start testing the -rc
kernels and the daily git snapshots as well as the -mm kernels. Test
if they build with your usual configuration, test if they build with
"allnoconfig", "allyesconfig", "allmodconfig" and perhaps a random
config or two. Test if they boot OK, if they run OK for a longer time,
etc.
When you find a problem you can try to fix the issue yourself and send
a patch to both the mailinglist and the person responsible for the
code in question. If you are unable to fix the problem yourself, then
send a detailed bugreport to the list and the person responsible for
the code.  Take a look at the REPORTING-BUGS file in the kernel source
dir and the Documentation/BUG-HUNTING file.

Helping to test pre-release kernels is a valuable effort. Run a new
kernel daily :-)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

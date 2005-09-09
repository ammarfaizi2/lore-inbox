Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbVIIRyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbVIIRyg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 13:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbVIIRyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 13:54:36 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:44676 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030295AbVIIRyg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 13:54:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HI8SXfqOjlB+KHS+Y86SqIuYi+Dsat1nOgty145fnrLjVZYAM/uSo//TmA5WiqVmeFkfbcjkWCdU+qTTQQUp6UxewFeOH73m4ygpfa9JdQ4NzWpjUvy90rUmLI9tN6kJpjVL0qLxTdI+hgEGdpes31glPup5LpnltOuxNWCBBRM=
Message-ID: <9c2327970509091054701b859e@mail.gmail.com>
Date: Fri, 9 Sep 2005 14:54:33 -0300
From: Weber Ress <weber_ress@hotmail.com>
Reply-To: weber_ress@hotmail.com
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: How to plan a kernel update ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a874849050908115547d9967c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c23279705090810123132447d@mail.gmail.com>
	 <9a874849050908115547d9967c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank's for all to help me. I can resume this conversation in two topics:

- If I have a server with 2.4, it's interesting create a process to
make frequent kernel update (2.4.1, 2.4.2, 2.4.3, etc), until the
latest 2.4 stable version. The same process be equal to a 2.6 server.

- To change a server in 2.4 stable version to 2.6 stable version, it's
interesting create a new server and reinstall all applications.

thank's

Weber Ress


On 9/8/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 9/8/05, Weber Ress <ress.weber@gmail.com> wrote:
> > Hi,
> >
> > I'm responsible to planning a kernel upgrade in many servers, from 2.4
> > version to 2.6.13 (last stable version), using Debian 3.1r0a
> >
> > My team has good technical skills, but they need to be led. I would
> > like know, what's the best pratices and recommendations that a project
> > manager need think BEFORE an kernel upgrade.
> >
> > A technical guy have a particular vision about this upgrade, but I
> > will be very been thankful if I receive from this community another
> > vision.. a vision centered in the project process (planning,
> > executing, controlling) to make this activity successfully.
> >
> 
> Ok, I'm no project manager, I guess I'd be clasified as one of the
> "technical guys", but I do upgrade a lot of kernels, so I'll tell you
> a little about what I do and what I'd recommend. Then you can do with
> that info what you like :)
> 
> The very first thing you want to do is to ensure that all core
> utilities/tools are up-to-date to versions that will work with your
> new kernel.
> If you download a copy of the 2.6.13 kernel source, extract it, and
> look in the file Documentation/Changes you'll see a list of tools and
> utils along with the minimum required version for them to work
> properly with that kernel. Ensure those tools are OK.
> 
> Once you are sure the core utils are up-to-date you need to go check
> whatever other important programs you have on the machine(s) and check
> that those are also able to run OK with the new kernel.
> 
> Once you are satisfied that everything is up to a level that'll work
> with the new kernel you can go build the new 2.6.13 kernel and drop it
> in place. You don't need to remove your existing kernel first, you can
> just install the 2.6.13 kernel side by side with the old one and test
> boot it, then if it doesn't work right you can always reboot back to
> the old one.
> 
> 
> Most likely you can find documentation for your distribution stating
> what version of it is "2.6 ready" - I use Slackware for example, and
> Slackware 10.1 is completely 2.6 kernel ready, so on a Slackware 10.1
> box there's no hassle at all, I just drop in a 2.6 kernel in place of
> the 2.4 one it installs by default and everything is good - all tools
> are already ready to cope.
> 
> 
> 
> --
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html
>

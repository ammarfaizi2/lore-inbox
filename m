Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWF1Svj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWF1Svj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWF1Svj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:51:39 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:37137 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S1750941AbWF1Svi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:51:38 -0400
Message-ID: <20060628225136.A2844@castle.nmd.msu.ru>
Date: Wed, 28 Jun 2006 22:51:36 +0400
From: Andrey Savochkin <saw@swsoft.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: dlezcano@fr.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com,
       Andrew Morton <akpm@osdl.org>, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru> <m14py6ldlj.fsf@ebiederm.dsl.xmission.com> <20060627215859.A20679@castle.nmd.msu.ru> <m1ejx9kj1r.fsf@ebiederm.dsl.xmission.com> <20060628150605.A29274@castle.nmd.msu.ru> <m1sllpfckx.fsf@ebiederm.dsl.xmission.com> <20060628212240.A1833@castle.nmd.msu.ru> <m1mzbxdu5q.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <m1mzbxdu5q.fsf@ebiederm.dsl.xmission.com>; from "Eric W. Biederman" on Wed, Jun 28, 2006 at 12:14:41PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 12:14:41PM -0600, Eric W. Biederman wrote:
> Andrey Savochkin <saw@swsoft.com> writes:
> 
> > On Wed, Jun 28, 2006 at 10:51:26AM -0600, Eric W. Biederman wrote:
> >> Andrey Savochkin <saw@swsoft.com> writes:
> >> 
> >> > One possible option to resolve this question is to show 2 relatively short
> >> > patches just introducing namespaces for sockets in 2 ways: with explicit
> >> > function parameters and using implicit current context.
> >> > Then people can compare them and vote.
> >> > Do you think it's worth the effort?
> >> 
> >> Given that we have two strong opinions in different directions I think it
> >> is worth the effort to resolve this.
> >
> > Do you have time to extract necessary parts of your old patch?
> > Or you aren't afraid of letting me draft an alternative version of socket
> > namespaces basing on your code? :)
> 
> I'm not terribly afraid.  I can always say you did it wrong. :)

:)

> I don't think I am going to have time today.  But since this conversation
> is slowing down and we are to getting into the technical details.  
> I will try and find some time.

Good.
I'll focus on my part then.

	Andrey

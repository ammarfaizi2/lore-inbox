Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbVBBQQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVBBQQA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVBBQP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:15:58 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:38349 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262388AbVBBQPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 11:15:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=UwysS1sb8Xe02ExzJWPtz+LvyzKI9Lq9SBqheaF0a6KnY4awzHosReHk8D3Lw98iaF98jS/TtTiZDEqaM33MagyxW8k9DnVB5TMsNJx8zOZJWNJq680RJRS1GR6STiXpMe/bcdjIHqfaX90DquITnfkYuB/6k8K8IJH0cauNlbI=
Message-ID: <c79c69b3050202081573f6335a@mail.gmail.com>
Date: Wed, 2 Feb 2005 17:15:16 +0100
From: Lethalman <lethalman88@gmail.com>
Reply-To: Lethalman <lethalman88@gmail.com>
To: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Linux Kernel Subversion Howto
In-Reply-To: <20050202155403.GE3117@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202155403.GE3117@crusoe.alcove-fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(first sorry for my poor English)
Very nice howto. It's useful for generic use of svn too.
The notations about converting bk to svn is really interesting... nice job!

Just a little error:
How to I ignore temporary build files ? <- to should be do

I would add this rule as a personal cross-development tecnique:
Before any kind of changes and commits, it would be good to update the
repository to prevent incompatibilities in the code if previous
changes was made by other developers.

On Wed, 2 Feb 2005 16:54:04 +0100, Stelian Pop <stelian@popies.net> wrote:
> Hi,
> 
> I've played lately a bit with Subversion and used it for managing
> the kernel sources, using Larry McVoy's bk2cvs bridge and Ben Collins'
> bkcvs2svn conversion script.
> 
> Since there is little information on the web on how to properly
> set up a SVN repository and use it for tracking the latest kernel
> tree, I wrote a small howto (modeled after the bk kernel howto)
> in case it can be useful for other people too.
> 
> Feel free to comment on it (but let's not start a new BK flamewar
> or SVN bashing session please). If there is enough interest I'll
> submit a patch to include this in the kernel Documentation/
> directory.
> 
> I've put it also on my web page along with the necessary scripts:
>         http://popies.net/svn-kernel/
> 
> And now a question to Larry and whoever else is involved in the
> bkcvs mirror on kernel.org: what is the periodicity of the CVS
> repository update ?
> 
> Stelian.
>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbVAFODb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbVAFODb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 09:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVAFODb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 09:03:31 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:33868 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262829AbVAFOD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 09:03:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KuTHMlGl6WNZu9ZG9ZlyNf/pkVL3DHWQ/CezV/5GTwxrhfolRQshFifMdLNXg+Z5U2b43/N0M0ZXv7vJ4/q3MVrXR+gIxmfjINqDg2po/UavkkRlZV9ep/q+yiqpUgsUxJqZVO7KUyqPv+aVTwYT65bE4FGSI9lbK49lV9wjIh4=
Message-ID: <4d8e3fd30501060603247e955a@mail.gmail.com>
Date: Thu, 6 Jan 2005 15:03:26 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Bill Davidsen <davidsen@tmr.com>,
       Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
In-Reply-To: <20050103183621.GA2885@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050103134727.GA2980@stusta.de>
	 <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com>
	 <20050103183621.GA2885@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005 13:36:21 -0500, Theodore Ts'o <tytso@mit.edu> wrote:
> On Mon, Jan 03, 2005 at 12:18:36PM -0500, Bill Davidsen wrote:
> > I have to say that with a few minor exceptions the introduction of new
> > features hasn't created long term (more than a few days) of problems. And
> > we have had that in previous stable versions as well. New features
> > themselves may not be totally stable, but in most cases they don't break
> > existing features, or are fixed in bk1 or bk2. What worries me is removing
> > features deliberately, and I won't beat that dead horse again, I've said
> > my piece.
> 
> Indeed.  Part of the problem is that we don't get that much testing
> with the rc* releases, so there are a lot of problems that don't get
> noticed until after 2.6.x ships.  This has been true for both 2.6.9
> and 2.6.10.  My personal practice is to never run with 2.6.x release,
> but wait for 2.6.x plus one or 2 days (i.e. bk1 or bk2).  The problems
> with this approach are that (1) out-of-tree patches against official
> versions of the kernel (i.e., things like the mppc/mppe patch) don't
> necessarly apply cleanly, and (2) other more destablizing patches get
> folded in right after 2.6.x ships, so there is a chance bk1 or bk2 may
> not be stable.

What's wrong in keeping the release management as is now plus
introducing a 2.6.X.Y series of kernels ?

In short:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109882220123966&w=2

Best,
Paolo Ciarrocchi

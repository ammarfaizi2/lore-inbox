Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUI0MR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUI0MR0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 08:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266798AbUI0MR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 08:17:26 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:58613 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266793AbUI0MRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 08:17:24 -0400
Message-ID: <35fb2e5904092705174e28b671@mail.gmail.com>
Date: Mon, 27 Sep 2004 13:17:22 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Thomas Habets <thomas@habets.pp.se>
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200409271401.03817.thomas@habets.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200409271401.03817.thomas@habets.pp.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004 14:00:56 +0200, Thomas Habets <thomas@habets.pp.se> wrote:
> > What we need is a mechanism to have a giant brainstraw emerge from the
> > front casing of the machine and suck the brains out of the guy running
> > a server with overcommit issues.
> 
> So the way to deal with OOM-killer issues is to laugh at people who encounter
> it? How very openbsd of you.

Actually I was leaning towards non-overcommit as an approach if you're
that worried (I know user non-overcommit is not a perfect solution). I
like Andrea's patch but this is one of these circular issues that'll
keep popping up from time to time because there isn't a perfect
solution that works for everyone all of the time. I typically find oom
results in things I want dying underneath me. Windows does something
with extending its paging file when this happens - has anyone looked
at weird alternatives such as this for desktop Linux?

> And I don't run X or xlock on any of my servers. IOW: this was not a server.

Yes ok. I was picking at the OOM Killer rather than at you - you just
didn't get my sense of humour but that's ok.

Jon.

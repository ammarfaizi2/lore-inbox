Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271158AbTG1WjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 18:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271174AbTG1WjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 18:39:14 -0400
Received: from CPE-65-29-19-166.mn.rr.com ([65.29.19.166]:41347 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S271158AbTG1WjL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 18:39:11 -0400
Subject: Re: 2.6.0-test2-mm1: Can't mount root
From: Shawn <core@enodev.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030728150245.42f57f89.akpm@osdl.org>
References: <1059428584.6146.9.camel@localhost>
	 <20030728144704.49c433bc.akpm@osdl.org>
	 <1059430015.6146.15.camel@localhost>
	 <20030728150245.42f57f89.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059431948.6146.45.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 28 Jul 2003 17:39:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I see now I was quite vague, and was still a little caffiene
deprived. To clarify what I meant by sentence #1:
        I should have seen that I ought to use 21:05 from the
        do_mounts.c patch I applied to -test1-mm2

As far as sentence #2, the boot messages seem to indicate that the
kernel understood "root=2105" as referring to (33,5), but still did not
mount root. This got me really confused.

As far as having it working, I'm waiting to get home to try your
suggestions.

The only other though thing I was trying to convey is that I don't
understand why -test1-mm2 with patch works while -test2-mm1 does not.

On Mon, 2003-07-28 at 17:02, Andrew Morton wrote:
> Shawn <core@enodev.com> wrote:
> >
> > Thank you, I didn't look very closely at the patch (really at all). 
> > 
> > The one thing making me think I had it right with "2105" was that the
> > kernel did seem to grok it as (33,5).
> 
> I don't understand.  Are you saying that you now have it working?
> If so, how?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264787AbUEYG6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264787AbUEYG6C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 02:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbUEYG6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 02:58:02 -0400
Received: from colo.khms.westfalen.de ([213.239.196.208]:56795 "EHLO
	colo.khms.westfalen.de") by vger.kernel.org with ESMTP
	id S264787AbUEYG56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 02:57:58 -0400
Date: 25 May 2004 08:43:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org
Message-ID: <99W4urOXw-B@khms.westfalen.de>
In-Reply-To: <1ZBgK-68x-3@gated-at.bofh.it>
Subject: Re: [RFD] Explicitly documenting patch submission
X-Mailer: CrossPoint v3.12d.kh13 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <1ZBgK-68x-3@gated-at.bofh.it>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@osdl.org (Linus Torvalds)  wrote on 25.05.04 in <1ZBgK-68x-3@gated-at.bofh.it>:

> On Mon, 24 May 2004, Albert Cahalan wrote:
> >
> > The wordy mix-case aspect is kind of annoying, and for
> > all that we don't get to differentiate actions.
>
> I actually really really don't want to differentiate actions. There's
> really no reason to try to separate things out, and quite often the
> actions are mixed anyway. Besides, if they all end up having the same
> technical meaning ("I have the right to pass on this patch") having
> separate flags is just sure to confuse the process.
>
> So what I want is something _really_ simple. Something that is
> unambigious, and cannot be confused with something else. And in
> particular, I want that sign-off line to be "strange" enough that there is
> no possibility of ever writing that line by mistake - so that it is clear
> that the only reason anybody would write something like "Signed-off-by:"
> is because it meant _that_ particular thing.

So it might be wise to add something approximately like this:

  Signed-off-by: Random C Developer <rcd@example.net> For: Linux kernel

Sometimes, pieces wander from one project into another, and tracking that  
as well could possibly help.

MfG Kai

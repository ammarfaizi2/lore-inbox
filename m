Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVAKTCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVAKTCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVAKTAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:00:48 -0500
Received: from waste.org ([216.27.176.166]:2958 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261949AbVAKTA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:00:26 -0500
Date: Tue, 11 Jan 2005 10:59:02 -0800
From: Matt Mackall <mpm@selenic.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Chris Wright <chrisw@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111185901.GS2940@waste.org>
References: <200501111305.j0BD58U2000483@localhost.localdomain> <87oefw3p7m.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87oefw3p7m.fsf@sulphur.joq.us>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 10:28:13AM -0600, Jack O'Quin wrote:
> Paul Davis <paul@linuxaudiosystems.com> writes:
> 
> >>Rlimits are neither UID/GID or PAM-specific. They fit well within
> >>the general model of UNIX security, extending an existing mechanism
> >>rather than adding a completely new one. That PAM happens to be the
> >>way rlimits are usually administered may be unfortunate, yes, but it
> >>doesn't mean that rlimits is the wrong way.
> 
> PAM is how most GNU/Linux systems manage rlimits.  It is very UID/GID
> oriented.  So from the sysadmin perspective, claiming that rlimits is
> "better" or "easier to manage" than "GID hacks" is bogus.

Yes, you're right, so let's invent something completely new and
inherently much less flexible so that the problem is made worse on
both fronts.

-- 
Mathematics is the supreme nostalgia of our time.

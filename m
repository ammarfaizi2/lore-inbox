Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVADSzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVADSzJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 13:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVADSzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 13:55:08 -0500
Received: from mail.joq.us ([67.65.12.105]:48036 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261800AbVADSyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 13:54:49 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <1104374603.9732.32.camel@krustophenia.net>
	<20050103140359.GA19976@infradead.org>
	<1104862614.8255.1.camel@krustophenia.net>
	<20050104182010.GA15254@infradead.org>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 04 Jan 2005 12:55:15 -0600
In-Reply-To: <20050104182010.GA15254@infradead.org> (Christoph Hellwig's
 message of "Tue, 4 Jan 2005 18:20:10 +0000")
Message-ID: <87u0pxhvn0.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> Which still doesn't mean it's the right design.  And no, I don't
> need the feature so I won't write it.  If you want a certain feature
> it's up to you to implement it in a way that's considered mergeable.

Which is what I have done.  I worked on it because no "real" kernel
developer seemed willing to solve it.  Having worked on other kernels
in an "earlier lifetime", I have *no* desire to do that any more.  I
would much rather write audio software.

But, the lack of this feature has been a continual impediment for
years now.  It affects not just me, but most other serious Linux audio
developers and many of our users.  We need a simple way for users to
configure a Digital Audio Workstation without having to run large,
complex, insecure audio applications as `root'.  Our competition runs
on Windows and Mac systems where no such configuration is needed.

Statements of the form "had I cared enough to do something about this
problem, I would have implemented it differently" are not much help.
This patch is small and clean.  It meshes with existing kernel LSM
mechanisms.  It solves a real problem affecting many Linux desktop
users.

I respectfully request that it be accepted for inclusion in 2.6.11.
-- 
  joq

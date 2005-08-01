Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVHATzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVHATzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVHATy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:54:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:13983 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261198AbVHATxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:53:45 -0400
Date: Mon, 1 Aug 2005 21:54:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: mort@sgi.com, torvalds@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [patch] remove sys_set_zone_reclaim()
Message-ID: <20050801195426.GA17548@elte.hu>
References: <20050801113913.GA7000@elte.hu> <20050801102903.378da54f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801102903.378da54f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> >  We could perhaps add a CAP_SYS_ADMIN-only sysctl for this hack,
> 
> That would be more appropriate.
> 
> (I'm still not sure what happened to the idea of adding a call to 
> "clear out this node+zone's pagecache now" rather than "set this 
> noed+zone's policy")

lets do that as a sysctl hack. It would be useful for debugging purposes 
anyway. But i'm not sure whether it's the same issue - Martin?

	Ingo

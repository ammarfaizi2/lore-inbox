Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbWCUNsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWCUNsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWCUNsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:48:10 -0500
Received: from mail.gmx.de ([213.165.64.20]:40652 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030375AbWCUNsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:48:09 -0500
X-Authenticated: #14349625
Subject: Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
In-Reply-To: <20060321133842.GB26171@w.ods.org>
References: <200603090036.49915.kernel@kolivas.org>
	 <200603212253.03637.kernel@kolivas.org> <1142946610.7807.43.camel@homer>
	 <200603220013.15870.kernel@kolivas.org>  <20060321133842.GB26171@w.ods.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 14:48:14 +0100
Message-Id: <1142948894.7807.69.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 14:38 +0100, Willy Tarreau wrote:
> What you describe is exactly a case for a tunable. Different people with
> different workloads want different values. Seems fair enough. After all,
> we already have /proc/sys/vm/swappiness, and things like that for the same
> reason : the default value should suit most users, and the ones with
> knowledge and different needs can tune their system. Maybe grace_{g1,g2}
> should be renamed to be more explicit, may be we can automatically tune
> one from the other and let only one tunable. But if both have a useful
> effect, I don't see a reason for hiding them.

I'm wide open to suggestions.  I tried to make it functional, flexible,
and above all, dirt simple.  Adding 'acceptable' would be cool :)

	-Mike


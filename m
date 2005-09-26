Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVIZOpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVIZOpH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 10:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVIZOpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 10:45:07 -0400
Received: from [212.76.81.238] ([212.76.81.238]:3332 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932148AbVIZOpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 10:45:05 -0400
From: Al Boldi <a1426z@gawab.com>
To: Rik van Riel <riel@redhat.com>, Neil Horman <nhorman@tuxdriver.com>
Subject: Re: Resource limits
Date: Mon, 26 Sep 2005 17:18:17 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200509251712.42302.a1426z@gawab.com> <Pine.LNX.4.63.0509252335560.28108@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0509252335560.28108@cuia.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509261718.17658.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Sun, 25 Sep 2005, Al Boldi wrote:
> > Resource limits in Linux, when available, are currently very limited.
> >
> > i.e.:
> > Too many process forks and your system may crash.
> > This can be capped with threads-max, but may lead you into a lock-out.
> >
> > What is needed is a soft, hard, and a special emergency limit that would
> > allow you to use the resource for a limited time to circumvent a
> > lock-out.
> >
> > Would this be difficult to implement?
>
> How would you reclaim the resource after that limited time is
> over ?  Kill processes?

That's one way,  but really, the issue needs some deep thought.
Leaving Linux exposed to a lock-out is rather frightening.

Neil Horman wrote:
> Whats insufficient about the per-user limits that can be imposed by the
> ulimit syscall?

Are they system wide or per-user?

--
Al


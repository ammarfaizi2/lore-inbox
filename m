Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVIZDg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVIZDg5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 23:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVIZDg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 23:36:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45795 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932360AbVIZDg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 23:36:56 -0400
Date: Sun, 25 Sep 2005 23:36:31 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Al Boldi <a1426z@gawab.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Resource limits
In-Reply-To: <200509251712.42302.a1426z@gawab.com>
Message-ID: <Pine.LNX.4.63.0509252335560.28108@cuia.boston.redhat.com>
References: <200509251712.42302.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2005, Al Boldi wrote:

> Resource limits in Linux, when available, are currently very limited.
> 
> i.e.:
> Too many process forks and your system may crash.
> This can be capped with threads-max, but may lead you into a lock-out.
> 
> What is needed is a soft, hard, and a special emergency limit that would 
> allow you to use the resource for a limited time to circumvent a lock-out.
> 
> Would this be difficult to implement?

How would you reclaim the resource after that limited time is
over ?  Kill processes?

-- 
All Rights Reversed

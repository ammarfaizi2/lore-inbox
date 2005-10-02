Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVJBVF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVJBVF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 17:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVJBVF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 17:05:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59847 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932075AbVJBVF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 17:05:58 -0400
Date: Sun, 2 Oct 2005 17:05:42 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <20051002204703.GG6290@lkcl.net>
Message-ID: <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com>
References: <20051002204703.GG6290@lkcl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2005, Luke Kenneth Casson Leighton wrote:

> and, what is the linux kernel?
> 
> it's a daft, monolithic design that is suitable and faster on
> single-processor systems, and that design is going to look _really_
> outdated, really soon.

Linux already has a number of scalable SMP synchronisation
mechanisms. The main scalability effort nowadays is about
the avoidance of so-called "cache line bouncing".

http://wiki.kernelnewbies.org/wiki/SMPSynchronisation

-- 
All Rights Reversed

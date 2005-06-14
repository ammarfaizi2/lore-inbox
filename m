Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVFNXrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVFNXrR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 19:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVFNXrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 19:47:17 -0400
Received: from serv01.siteground.net ([70.85.91.68]:32475 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261425AbVFNXrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 19:47:14 -0400
Date: Tue, 14 Jun 2005 16:46:11 -0700 (PDT)
From: christoph <christoph@scalex86.org>
X-X-Sender: christoph@ScMPusgw
To: Andrew Morton <akpm@osdl.org>
cc: ak@suse.de, linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Move some variables into the "most_readonly" section??
In-Reply-To: <20050614162354.6aabe57e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0506141644160.4099@ScMPusgw>
References: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw> <20050608131839.GP23831@wotan.suse.de>
 <Pine.LNX.4.62.0506141551350.3676@ScMPusgw> <20050614162354.6aabe57e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2005, Andrew Morton wrote:

> I think readmostliness and alignment are mostly-unrelated concepts and
> should have separate tag thingies.  IOW,
> __cacheline_aligned_mostly_readonly goes away and to handle things like the
> cpu maps we do:

Yup that makes the whole thing much more sane. Can we specify multiple 
attributes to a variable?


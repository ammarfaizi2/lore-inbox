Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVCHIqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVCHIqG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 03:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVCHIqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 03:46:06 -0500
Received: from waste.org ([216.27.176.166]:25788 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261886AbVCHIqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 03:46:00 -0500
Date: Tue, 8 Mar 2005 00:45:24 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: paul@linuxaudiosystems.com, joq@io.com, cfriesen@nortelnetworks.com,
       chrisw@osdl.org, hch@infradead.org, rlrevell@joe-job.com,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050308084524.GQ3120@waste.org>
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308043349.GG3120@waste.org> <20050307225535.146f8162.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307225535.146f8162.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 10:55:35PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> >  Add a pair of rlimits for allowing non-root tasks to raise nice and rt
> >  priorities. Defaults to traditional behavior. Originally written by
> >  Chris Wright.
> 
> It needs some dinking with because Ingo has been playing games in my
> resource.h.  Here's the end result.  Unlike yours, this will work on alpha,
> mips and sparc[64], too ;)

Boggle. The diffstat of this patch (and Chris') looks identical to
mine. Whatever..

-- 
Mathematics is the supreme nostalgia of our time.

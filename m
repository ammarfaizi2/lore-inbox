Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268532AbUJMGm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268532AbUJMGm2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 02:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268501AbUJMGm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 02:42:28 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:53421 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269157AbUJMGli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 02:41:38 -0400
Date: Wed, 13 Oct 2004 16:39:55 +1000
From: Nathan Scott <nathans@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-xfs@oss.sgi.com
Subject: Re: Page cache write performance issue
Message-ID: <20041013063955.GA2079@frodo>
References: <20041013054452.GB1618@frodo> <20041012231945.2aff9a00.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012231945.2aff9a00.akpm@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Oct 12, 2004 at 11:19:45PM -0700, Andrew Morton wrote:
> Nathan Scott <nathans@sgi.com> wrote:
> >
> >  So, any ideas what happened to 2.6.9?
> 
> Does reverting the below fix it up?

Reverting that one improves things slightly - I move up from
~4MB/sec to ~17MB/sec; thats just under a third of the 2.6.8
numbers I was seeing though, unfortunately.

cheers.

-- 
Nathan

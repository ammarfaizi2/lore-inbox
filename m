Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267614AbUIUM0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267614AbUIUM0O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 08:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267601AbUIUM0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 08:26:14 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:26383 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267618AbUIUMZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 08:25:14 -0400
Date: Tue, 21 Sep 2004 13:25:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BK tree] [drm] remove counter macros..
Message-ID: <20040921132511.A22641@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0409211148290.22187@skynet> <20040921130936.A22429@infradead.org> <Pine.LNX.4.58.0409211316310.22187@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409211316310.22187@skynet>; from airlied@linux.ie on Tue, Sep 21, 2004 at 01:21:38PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2004 at 01:21:38PM +0100, Dave Airlie wrote:
> 
> Well this was only a direct macro removal,

Sure, and I really like the patch.  But seeing code posted is the best
place for further suggestions in that area.

> I'm contemplating removing the
> counters as to be honest I'm not sure any drm developer as actually used
> them since day one .. (and maybe not even then)... but I'll leave that for
> another time, as there might be a wierd use of them somewhere...

Sounds like a good idea.  Especially as dev->counts are atomic_ts that are
rather expensive.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267599AbUIUMJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267599AbUIUMJm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 08:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267601AbUIUMJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 08:09:42 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:25359 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267599AbUIUMJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 08:09:40 -0400
Date: Tue, 21 Sep 2004 13:09:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK tree] [drm] remove counter macros..
Message-ID: <20040921130936.A22429@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0409211148290.22187@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409211148290.22187@skynet>; from airlied@linux.ie on Tue, Sep 21, 2004 at 11:50:07AM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While I definitly approve this patch is there a specific reason for this
array instead of individual members like

	lock_cnt, open_cnt, close_cnt, etc..?

also the optional counters seem to be largely overlapping, why not always
all four thta exist and if some drivers don't want to update them they'd
just not update them

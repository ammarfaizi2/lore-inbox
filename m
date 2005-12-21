Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbVLUUyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVLUUyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 15:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVLUUyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 15:54:50 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:39811 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1751193AbVLUUyt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 15:54:49 -0500
Date: Wed, 21 Dec 2005 21:23:56 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Robin Holt <holt@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 1/1] Fix genksyms handling of DEFINE_PER_CPU(struct foo_s *, bar);
Message-ID: <20051221202356.GA31487@mars.ravnborg.org>
References: <20051221203601.GB20619@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221203601.GB20619@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 02:36:01PM -0600, Robin Holt wrote:
> This is a one-line change to parse.y.  It results in rebuilding the
> scripts/genksyms/*_shipped files.  Those are the next four patches.
Does this differ from the first patch-set you sent out?
I plan to apply these so they will be part of next round of kbuild
updates - which will take place during next merge window.

	Sam

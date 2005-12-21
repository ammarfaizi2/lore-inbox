Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVLUWDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVLUWDB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVLUWDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:03:00 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:17559 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932217AbVLUWDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:03:00 -0500
Date: Wed, 21 Dec 2005 16:02:51 -0600
From: Robin Holt <holt@sgi.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Robin Holt <holt@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch 1/1] Fix genksyms handling of DEFINE_PER_CPU(struct foo_s *, bar);
Message-ID: <20051221220251.GA2924@lnx-holt.americas.sgi.com>
References: <20051221203601.GB20619@lnx-holt.americas.sgi.com> <20051221202356.GA31487@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221202356.GA31487@mars.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 09:23:56PM +0100, Sam Ravnborg wrote:
> On Wed, Dec 21, 2005 at 02:36:01PM -0600, Robin Holt wrote:
> > This is a one-line change to parse.y.  It results in rebuilding the
> > scripts/genksyms/*_shipped files.  Those are the next four patches.
> Does this differ from the first patch-set you sent out?
> I plan to apply these so they will be part of next round of kbuild
> updates - which will take place during next merge window.

They are the same.  It took me four to finally get all the
parts out and on the lkml.

Thanks,
Robin

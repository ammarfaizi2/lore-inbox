Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbTE1VlT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 17:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTE1VlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 17:41:19 -0400
Received: from smtp2.pp.htv.fi ([213.243.153.6]:41176 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261179AbTE1VlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 17:41:18 -0400
Date: Thu, 29 May 2003 00:55:05 +0300
From: Richard Braakman <dark@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Patch for strncmp use in s390 in 2.5
Message-ID: <20030528215505.GA3779@cs140102.pp.htv.fi>
References: <20030528162019.A3492@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528162019.A3492@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 04:20:19PM -0400, Pete Zaitcev wrote:
> I didn't see this posted before. Sorry if I missed it.
> It's a harmless buglet which causes false positives with correctness
> checking tools, and so annoys me.

Are you sure it's harmless?  Your patch changes the meaning from an
exact match to a prefix match.  I think it's intended to be an exact
match, but I don't know why it doesn't just use strcmp().

Richard Braakman

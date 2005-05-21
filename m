Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVEUB2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVEUB2X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 21:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVEUB2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 21:28:23 -0400
Received: from holomorphy.com ([66.93.40.71]:6875 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261627AbVEUB2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 21:28:20 -0400
Date: Fri, 20 May 2005 18:25:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the obsolete raw driver
Message-ID: <20050521012505.GD2057@holomorphy.com>
References: <20050521001925.GQ5112@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050521001925.GQ5112@stusta.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2005 at 02:19:25AM +0200, Adrian Bunk wrote:
> Since kernel 2.6.3 the Kconfig text explicitely stated this driver was 
> obsolete.
> It seems to be time to remove it.
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

9 point releases is nowhere long enough. This removal needs to wait for
similar amounts of time as other removed interfaces (c.f. devfs, which
is far more offensive).

In general there are staging rules for this sort of affair, and although
I'm no expert in their fine points, nor can I even say what the exact
criteria are, but it's rather clear in this instance it's over the line.
I suspect a major release, planned as a staging ground for things like
e.g. this and removing devfs, would be the most appropriate time for it.


-- wli

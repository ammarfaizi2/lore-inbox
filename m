Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268334AbUHXVR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268334AbUHXVR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268336AbUHXVR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:17:26 -0400
Received: from waste.org ([209.173.204.2]:45728 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268334AbUHXVRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:17:23 -0400
Date: Tue, 24 Aug 2004 16:17:17 -0500
From: Matt Mackall <mpm@selenic.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] [2/4] /dev/random: Add pool name to entropy store
Message-ID: <20040824211716.GG5414@waste.org>
References: <E1By1Sm-0001TM-V7@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1By1Sm-0001TM-V7@thunk.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 12:57:16AM -0400, Theodore Ts'o wrote:
> 
> This adds a pool name to the entropy_store data structure, which
> simplifies the debugging code, and makes the code more generic for
> adding additional entropy pools.

My version from last year called these "input", "blocking", and
"nonblocking", which I think added substantially to the readability
here.

-- 
Mathematics is the supreme nostalgia of our time.

Return-Path: <linux-kernel-owner+w=401wt.eu-S932297AbXADGgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbXADGgk (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 01:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbXADGgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 01:36:40 -0500
Received: from usul.saidi.cx ([204.11.33.34]:56697 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932297AbXADGgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 01:36:39 -0500
Message-ID: <459CA049.2080505@overt.org>
Date: Wed, 03 Jan 2007 22:35:53 -0800
From: Philip Langdale <philipl@overt.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: Alex Dubov <oakad@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19] mmc: Add support for SDHC cards (Take 2)
References: <459928F3.9010804@overt.org> <20070103150620.ac733abb.akpm@osdl.org> <459C8FA4.7080709@overt.org> <459C97A9.3060907@drzeus.cx>
In-Reply-To: <459C97A9.3060907@drzeus.cx>
X-Enigmail-Version: 0.93.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> 
> Amen to that. All hw vendors that implement this particular form of
> brain damage should be dragged out and shot.
> 
> I'll fix a patch for this later on.

See my updated Take 3 patch. I've implemented a uniqueness fix by
adding additional RSP flags do make R6 and R7 unique. I don't know
if this is what you wanted, but it works without being too ugly.

However, also note my caveat that it's not clear if tifm or imxmmc
can ever be made to work with SD 2.0 cards. *sigh*

--phil

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263034AbVD2Wbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263034AbVD2Wbq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 18:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbVD2Wbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 18:31:45 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:1033 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S263034AbVD2Wa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 18:30:57 -0400
Date: Sat, 30 Apr 2005 00:30:52 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Sean <seanlkml@sympatico.ca>, Matt Mackall <mpm@selenic.com>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Message-ID: <20050429223052.GD28540@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andrea Arcangeli <andrea@suse.de>, Sean <seanlkml@sympatico.ca>,
	Matt Mackall <mpm@selenic.com>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1> <20050429201957.GJ17379@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429201957.GJ17379@opteron.random>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 10:19:57PM +0200, Andrea Arcangeli wrote:
> such a system might fall apart under load, converting on the fly from
> git to network-optimized format sound quite expensive operation, even
> ignorign the initial decompression of the payload.

Nothing a little caching can't solve.  Given that git's objects are
immutable caching is especially easy to do, you can have the delta
reference indexes in the filename.

  OG.


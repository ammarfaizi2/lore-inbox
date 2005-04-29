Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVD2URO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVD2URO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262950AbVD2UPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:15:38 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:29544
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262384AbVD2UOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:14:52 -0400
Date: Fri, 29 Apr 2005 22:19:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Sean <seanlkml@sympatico.ca>
Cc: Matt Mackall <mpm@selenic.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Message-ID: <20050429201957.GJ17379@opteron.random>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3817.10.10.10.24.1114756831.squirrel@linux1>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 02:40:31AM -0400, Sean wrote:
> There isn't anything preventing optomized transfer protocols for git. 

such a system might fall apart under load, converting on the fly from
git to network-optimized format sound quite expensive operation, even
ignorign the initial decompression of the payload. If something it
should be pre-converted to mercurial, so you checkout from mercurial and
you apply to local git.

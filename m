Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWBVRLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWBVRLE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWBVRLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:11:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36504 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751371AbWBVRLC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:11:02 -0500
Date: Wed, 22 Feb 2006 17:10:17 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: David Zeuthen <david@fubar.dk>
Cc: Linus Torvalds <torvalds@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, Greg KH <gregkh@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222171016.GB27946@ftp.linux.org.uk>
References: <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com> <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI> <20060222152743.GA22281@vrfy.org> <Pine.LNX.4.64.0602220737170.30245@g5.osdl.org> <1140625103.21517.18.camel@daxter.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140625103.21517.18.camel@daxter.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 11:18:22AM -0500, David Zeuthen wrote:
> Oh, you know, I don't think that's exactly how it works; HAL is pretty
> much at the mercy of what changes goes into the kernel. And, trust me,
> the changes we need to cope with from your so-called stable API are not
> so nice. 
> 
> But I realize these changes are important because it's progress and back
> in 2.6.0 things were horribly broken for at least desktop workloads [1].
> It also makes me release note that newer HAL releases require newer
> kernel and udev releases and that's alright. In fact it's perfectly
> fine. We get users to upgrade to the latest and greatest and we keep
> making good progress. That's open source at it's finest I think.

No, it is not.  Just try to find a point where breakage had been introduced
into e.g. a driver, when known-good and known-bad versions are on the
different sides of your change requiring userland "upgrade".

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264769AbRGCPKl>; Tue, 3 Jul 2001 11:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264771AbRGCPKc>; Tue, 3 Jul 2001 11:10:32 -0400
Received: from home.linux3d.org ([216.86.203.152]:52477 "EHLO harlot.rb.ca.us")
	by vger.kernel.org with ESMTP id <S264769AbRGCPKT>;
	Tue, 3 Jul 2001 11:10:19 -0400
Date: Tue, 3 Jul 2001 08:10:39 -0700
From: Daryll Strauss <daryll@valinux.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT please; Sybase 12.5
Message-ID: <20010703081039.C3942@newbie>
In-Reply-To: <3B3C4CB4.6B3D2B2F@kegel.com> <20010703104253.B29868@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010703104253.B29868@redhat.com>; from sct@redhat.com on Tue, Jul 03, 2001 at 10:42:53AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2001 at 10:42:53AM +0100, Stephen C. Tweedie wrote:
> On Fri, Jun 29, 2001 at 02:39:00AM -0700, Dan Kegel wrote:
> 
> > It supports raw partitions, which is good; that might satisfy my
> > boss (although the administration will be a pain, and I'm not
> > sure whether it's really supported by Dell RAID devices).
> 
> All block devices support raw IO --- the raw IO mechanism talks to the
> device driver through the normal kernel-internal block IO entry
> points.
> 
> > I'd prefer O_DIRECT :-(
> 
> Andrea Arcangeli has already posted patches you can try for ext2.  The
> functionality isn't in the mainline kernel yet, though.

I recall hearing about a problem with the md device and raw IO. It was
something about the block sizes not matching causing performance
problems. Has anything been done to improve those issues?

					    - |Daryll

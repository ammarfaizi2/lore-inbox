Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262170AbRGCJsb>; Tue, 3 Jul 2001 05:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262116AbRGCJsV>; Tue, 3 Jul 2001 05:48:21 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:8174 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262170AbRGCJsO>; Tue, 3 Jul 2001 05:48:14 -0400
Date: Tue, 3 Jul 2001 10:42:53 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: O_DIRECT please; Sybase 12.5
Message-ID: <20010703104253.B29868@redhat.com>
In-Reply-To: <3B3C4CB4.6B3D2B2F@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B3C4CB4.6B3D2B2F@kegel.com>; from dank@kegel.com on Fri, Jun 29, 2001 at 02:39:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 29, 2001 at 02:39:00AM -0700, Dan Kegel wrote:

> It supports raw partitions, which is good; that might satisfy my
> boss (although the administration will be a pain, and I'm not
> sure whether it's really supported by Dell RAID devices).

All block devices support raw IO --- the raw IO mechanism talks to the
device driver through the normal kernel-internal block IO entry
points.

> I'd prefer O_DIRECT :-(

Andrea Arcangeli has already posted patches you can try for ext2.  The
functionality isn't in the mainline kernel yet, though.

--Stephen

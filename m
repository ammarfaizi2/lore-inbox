Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261291AbRESUir>; Sat, 19 May 2001 16:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261324AbRESUih>; Sat, 19 May 2001 16:38:37 -0400
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:38153 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S261291AbRESUiX>; Sat, 19 May 2001 16:38:23 -0400
Date: Sat, 19 May 2001 16:20:11 -0400
From: Michael Meissner <meissner@spectacle-pond.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        Miles Lane <miles@megapathdsl.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010519162011.A22211@munchkin.spectacle-pond.org>
In-Reply-To: <E504453C04C1D311988D00508B2C5C2DF2F9E1@mail11.gruppocredit.it> <3B0261EC.23BE5EF0@idb.hist.no> <031ypp1oi2.fsf@colargol.tihlde.org> <3B028063.67442F62@idb.hist.no> <990030651.932.3.camel@agate> <20010516121815.B16609@munchkin.spectacle-pond.org> <20010518151750.A10515@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010518151750.A10515@redhat.com>; from sct@redhat.com on Fri, May 18, 2001 at 03:17:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2001 at 03:17:50PM +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Wed, May 16, 2001 at 12:18:15PM -0400, Michael Meissner wrote:
> 
> > With the current LABEL= support, you won't be able to mount the disks with
> > duplicate labels, but you can still mount them via /dev/sd<xxx>.
> 
> Or you can fall back to mounting by UUID, which is globally unique and
> still avoids referencing physical location.  You also don't need to
> manually set LABELs for UUID to work: all e2fsprogs over the past
> couple of years have set UUID on partitions, and e2fsck will create a
> new UUID if it sees an old filesystem that doesn't already have one.

Presumably, a new UUID is created each time format a partition, which means it
is a slight bit of hassle if you have to reload a partition from a dump, or
copy a partition to another disk drive.  In the scheme of things, it is not a
large hassle perhaps, but it is a hassle.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482

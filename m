Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261889AbRESQn6>; Sat, 19 May 2001 12:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261882AbRESQnr>; Sat, 19 May 2001 12:43:47 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:510 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261889AbRESQne>; Sat, 19 May 2001 12:43:34 -0400
Date: Sat, 19 May 2001 17:43:07 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Michael Meissner <meissner@spectacle-pond.org>,
        Miles Lane <miles@megapathdsl.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010519174307.W8080@redhat.com>
In-Reply-To: <E504453C04C1D311988D00508B2C5C2DF2F9E1@mail11.gruppocredit.it> <3B0261EC.23BE5EF0@idb.hist.no> <031ypp1oi2.fsf@colargol.tihlde.org> <3B028063.67442F62@idb.hist.no> <990030651.932.3.camel@agate> <20010516121815.B16609@munchkin.spectacle-pond.org> <20010518151750.A10515@redhat.com> <20010519172932.C4434@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010519172932.C4434@metastasis.f00f.org>; from cw@f00f.org on Sat, May 19, 2001 at 05:29:32PM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 19, 2001 at 05:29:32PM +1200, Chris Wedgwood wrote:
> 
>     Or you can fall back to mounting by UUID, which is globally
>     unique and still avoids referencing physical location.  You also
>     don't need to manually set LABELs for UUID to work: all e2fsprogs
>     over the past couple of years have set UUID on partitions, and
>     e2fsck will create a new UUID if it sees an old filesystem that
>     doesn't already have one.
> 
> Other filesystems such as reiserfs at present don't have such a
> thing. I brought this a while ago and in theory it's not too hard, we
> just need to get Hans to officially designate part of the SB or
> whatever for the UUID.

There are other ways to deal with it: both md and (I think, in newer
releases) LVM can pick up their logical config from scanning physical
volumes for IDs, and so present a consistent logical device namespace
despite physical devices moving around. 

--Stephen

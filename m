Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261435AbREUNfS>; Mon, 21 May 2001 09:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261445AbREUNfI>; Mon, 21 May 2001 09:35:08 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:64402 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261435AbREUNev>; Mon, 21 May 2001 09:34:51 -0400
Date: Mon, 21 May 2001 14:34:37 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Michael Meissner <meissner@spectacle-pond.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Miles Lane <miles@megapathdsl.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010521143437.B8080@redhat.com>
In-Reply-To: <E504453C04C1D311988D00508B2C5C2DF2F9E1@mail11.gruppocredit.it> <3B0261EC.23BE5EF0@idb.hist.no> <031ypp1oi2.fsf@colargol.tihlde.org> <3B028063.67442F62@idb.hist.no> <990030651.932.3.camel@agate> <20010516121815.B16609@munchkin.spectacle-pond.org> <20010518151750.A10515@redhat.com> <20010519162011.A22211@munchkin.spectacle-pond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010519162011.A22211@munchkin.spectacle-pond.org>; from meissner@spectacle-pond.org on Sat, May 19, 2001 at 04:20:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 19, 2001 at 04:20:11PM -0400, Michael Meissner wrote:
> On Fri, May 18, 2001 at 03:17:50PM +0100, Stephen C. Tweedie wrote:

> Presumably, a new UUID is created each time format a partition, which means it
> is a slight bit of hassle if you have to reload a partition from a dump, or
> copy a partition to another disk drive.  In the scheme of things, it is not a
> large hassle perhaps, but it is a hassle.

Right.  Tune2fs can reset the UUID on an existing filesystem, but if
you want something immune from the possible collisions of LABEL
namespaces, you can't really avoid ending up with different IDs on
filesystems after a restore.

Cheers,
 Stephen

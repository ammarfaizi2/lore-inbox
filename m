Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261643AbRESE3n>; Sat, 19 May 2001 00:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbRESE3d>; Sat, 19 May 2001 00:29:33 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:14087 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S261643AbRESE30>; Sat, 19 May 2001 00:29:26 -0400
Date: Sat, 19 May 2001 17:29:32 +1200
From: Chris Wedgwood <cw@f00f.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        Miles Lane <miles@megapathdsl.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010519172932.C4434@metastasis.f00f.org>
In-Reply-To: <E504453C04C1D311988D00508B2C5C2DF2F9E1@mail11.gruppocredit.it> <3B0261EC.23BE5EF0@idb.hist.no> <031ypp1oi2.fsf@colargol.tihlde.org> <3B028063.67442F62@idb.hist.no> <990030651.932.3.camel@agate> <20010516121815.B16609@munchkin.spectacle-pond.org> <20010518151750.A10515@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010518151750.A10515@redhat.com>; from sct@redhat.com on Fri, May 18, 2001 at 03:17:50PM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    Or you can fall back to mounting by UUID, which is globally
    unique and still avoids referencing physical location.  You also
    don't need to manually set LABELs for UUID to work: all e2fsprogs
    over the past couple of years have set UUID on partitions, and
    e2fsck will create a new UUID if it sees an old filesystem that
    doesn't already have one.

Other filesystems such as reiserfs at present don't have such a
thing. I brought this a while ago and in theory it's not too hard, we
just need to get Hans to officially designate part of the SB or
whatever for the UUID.



  --cw

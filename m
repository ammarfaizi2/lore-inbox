Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261939AbRESSW5>; Sat, 19 May 2001 14:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261948AbRESSWh>; Sat, 19 May 2001 14:22:37 -0400
Received: from idiom.com ([216.240.32.1]:65032 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S261939AbRESSW3>;
	Sat, 19 May 2001 14:22:29 -0400
Message-ID: <3B06B9A5.54C328C5@namesys.com>
Date: Sat, 19 May 2001 11:21:25 -0700
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: "Stephen C. Tweedie" <sct@redhat.com>,
        Michael Meissner <meissner@spectacle-pond.org>,
        Miles Lane <miles@megapathdsl.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "Vladimir V. Saveliev" <monstr@namesys.com>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E504453C04C1D311988D00508B2C5C2DF2F9E1@mail11.gruppocredit.it> <3B0261EC.23BE5EF0@idb.hist.no> <031ypp1oi2.fsf@colargol.tihlde.org> <3B028063.67442F62@idb.hist.no> <990030651.932.3.camel@agate> <20010516121815.B16609@munchkin.spectacle-pond.org> <20010518151750.A10515@redhat.com> <20010519172932.C4434@metastasis.f00f.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
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
> 
>   --cw
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
work out a patch with monstr, and I am sure he will accept it.

Hans

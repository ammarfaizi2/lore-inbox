Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261735AbRESJQy>; Sat, 19 May 2001 05:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261726AbRESJQp>; Sat, 19 May 2001 05:16:45 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:48547 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S261722AbRESJQb>; Sat, 19 May 2001 05:16:31 -0400
Message-ID: <3B0638D1.9AF50C79@uow.edu.au>
Date: Sat, 19 May 2001 19:11:45 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
 inuserspace
In-Reply-To: <3B06194B.C487240C@gnu.org> <Pine.GSO.4.21.0105190259350.3724-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> > (2) what about bootstrapping?  how do you find the root device?
> > Do you do "root=/dev/hda/offset=63,limit=1235823"?  Bit nasty.
> 
> Ben's patch makes initrd mandatory.
> 

Can this be fixed?  I've *never* had to futz with initrd.
Probably most systems are the same.  It seems a step
backward to make it necessary.

-

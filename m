Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267836AbRGRI5z>; Wed, 18 Jul 2001 04:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267847AbRGRI5o>; Wed, 18 Jul 2001 04:57:44 -0400
Received: from [213.98.126.44] ([213.98.126.44]:45572 "HELO trasno.org")
	by vger.kernel.org with SMTP id <S267845AbRGRI5c>;
	Wed, 18 Jul 2001 04:57:32 -0400
To: Chris Wedgwood <cw@f00f.org>
Cc: John Alvord <jalvo@mbay.net>, Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write
In-Reply-To: <Pine.LNX.4.20.0107142304010.17541-100000@otter.mbay.net>
	<20010715180752.B7993@weta.f00f.org>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20010715180752.B7993@weta.f00f.org>
Date: 16 Jul 2001 20:31:57 -0400
Message-ID: <m2ofqk5rb6.fsf@mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "chris" == Chris Wedgwood <cw@f00f.org> writes:

chris> On Sat, Jul 14, 2001 at 11:05:36PM -0700, John Alvord wrote:
chris> In the IBM solution to this (1977-78, VM/CMS) the critical data was
chris> written at the begining and the end of the block. If the two data items
chris> didn't match then the block was rejected.

chris> Neat.


chris> Simple and effective.  Presumably you can also checksum the block, and
chris> check that.

There is the rumor (I can't confirm that), that you need checksums,
that some disks are able to write well the beginning & the end of the
sector and put garbage in the middle in the case of problems.  I
have never been able to reproduce that errors, but ....

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy

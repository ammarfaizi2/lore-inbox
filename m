Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbRGOGIK>; Sun, 15 Jul 2001 02:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265941AbRGOGIA>; Sun, 15 Jul 2001 02:08:00 -0400
Received: from weta.f00f.org ([203.167.249.89]:58243 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S265909AbRGOGHt>;
	Sun, 15 Jul 2001 02:07:49 -0400
Date: Sun, 15 Jul 2001 18:07:52 +1200
From: Chris Wedgwood <cw@f00f.org>
To: John Alvord <jalvo@mbay.net>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010715180752.B7993@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.20.0107142304010.17541-100000@otter.mbay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.20.0107142304010.17541-100000@otter.mbay.net>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2001 at 11:05:36PM -0700, John Alvord wrote:

    In the IBM solution to this (1977-78, VM/CMS) the critical data was
    written at the begining and the end of the block. If the two data items
    didn't match then the block was rejected.

Neat.


Simple and effective.  Presumably you can also checksum the block, and
check that.



  --cw

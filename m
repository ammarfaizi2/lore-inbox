Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263960AbRGNRAv>; Sat, 14 Jul 2001 13:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264096AbRGNRAl>; Sat, 14 Jul 2001 13:00:41 -0400
Received: from weta.f00f.org ([203.167.249.89]:30851 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S263960AbRGNRA1>;
	Sat, 14 Jul 2001 13:00:27 -0400
Date: Sun, 15 Jul 2001 05:00:29 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010715050029.C6963@weta.f00f.org>
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu> <20010715025001.B6722@weta.f00f.org> <p05100305b7761878d7b1@[207.213.214.37]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p05100305b7761878d7b1@[207.213.214.37]>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2001 at 08:41:52AM -0700, Jonathan Lundell wrote:

    NetApp uses a large system-local NVRAM buffer, do they not?

Yes... and for clusters its chared via some kind of NUMA interconnect.
Anyhow, thats doesn't prevent disk/fs corruption alone, I suspect it
might be one of the reasons they use raid4 and not raid5 (plus they
also get better LVM management).



  --cw


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266652AbRGOPde>; Sun, 15 Jul 2001 11:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266653AbRGOPdY>; Sun, 15 Jul 2001 11:33:24 -0400
Received: from weta.f00f.org ([203.167.249.89]:8580 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266652AbRGOPdS>;
	Sun, 15 Jul 2001 11:33:18 -0400
Date: Mon, 16 Jul 2001 03:33:22 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010716033322.B10713@weta.f00f.org>
In-Reply-To: <E15LntD-000489-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15LntD-000489-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 04:32:59PM +0100, Alan Cox wrote:

    Another way is to time
    
    	write block
    	write barrier
    	write same block
    	write barrier
    	repeat
    
    If the write barrier is working you should be able to measure the
    drive rpm 8)

Yeah, I was thinking of doing this with caches turned off, since I
know how to do that, but not a write-barrier.




  --cs

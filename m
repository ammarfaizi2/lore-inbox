Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316671AbSEQTyO>; Fri, 17 May 2002 15:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSEQTyN>; Fri, 17 May 2002 15:54:13 -0400
Received: from dsl-213-023-043-065.arcor-ip.net ([213.23.43.65]:63620 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316671AbSEQTyL>;
	Fri, 17 May 2002 15:54:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: [PATCH] remove 2TB block device limit
Date: Fri, 17 May 2002 21:52:23 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Anton Altaparmakov <aia21@cantab.net>,
        Peter Chubb <peter@chubb.wattle.id.au>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        axboe@suse.de, akpm@zip.com.au, martin@dalecki.de,
        neilb@cse.unsw.edu.au
In-Reply-To: <200205171332.IAA93516@tomcat.admin.navo.hpc.mil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E178nm3-000074-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 May 2002 15:32, Jesse Pollard wrote:
> Note - most these really large filesystems allow the inode tables and
> bitmaps to be stored on disks with a relatively small blocksize (raid 5),
> and the data on different drives (striped) with a large block size (I believe
> ours is 64K to 128K sized data blocks, inode/bitmaps are 16K-32K.) This is
> done for two reasons:

Since we're on this subject, and you have experience with these large block
sizes, where exactly do you see the large savings?

  - setup cost of the disk transfer?
  - rotational latency of small transfers?
  - setup cost of the network transfer?
  - interrupt processing overhead?
  - other?

-- 
Daniel

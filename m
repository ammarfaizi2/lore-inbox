Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271705AbRH0MFu>; Mon, 27 Aug 2001 08:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271704AbRH0MFj>; Mon, 27 Aug 2001 08:05:39 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:61193 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S271703AbRH0MF1>; Mon, 27 Aug 2001 08:05:27 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15242.14151.657039.773548@gargle.gargle.HOWL>
Date: Mon, 27 Aug 2001 16:04:23 +0400
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs can't replay on READ-ONLY partition
In-Reply-To: <Pine.LNX.4.33.0108271950300.852-100000@boston.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.33.0108271950300.852-100000@boston.corp.fedex.com>
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua writes:
 > 
 > I wanted to have Read-Only partition startup in /etc/fstab, but
 > reiserfs can't seems to replay the log if the partition is mounted
 > as read-only.
 > 
 > It gives a warning, and I don't think it's replaying the logs at all,

If you are talking about message

"Warning, log replay starting on readonly filesystem"

then, journal is replayed anyway.

 > 
 > It seems so because if I mount, unmount the partition, repeatedly, it'll
 > keep warning and replaying the logs everytime. Only until I mount the
 > partition as read-write will the actual log be replayed ... this seems so,
 > as the moment I mount it as rw, unmount it, and mount it again, the replay
 > goes away and the partition get mounted very fast.
 > 

Nikita.

 > Thanks,
 > Jeff
 > [ jchua@fedex.com ]

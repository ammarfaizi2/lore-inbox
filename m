Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292421AbSCDPpU>; Mon, 4 Mar 2002 10:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292382AbSCDPpN>; Mon, 4 Mar 2002 10:45:13 -0500
Received: from due.stud.ntnu.no ([129.241.56.71]:51616 "EHLO due.stud.ntnu.no")
	by vger.kernel.org with ESMTP id <S292283AbSCDPoz>;
	Mon, 4 Mar 2002 10:44:55 -0500
Date: Mon, 4 Mar 2002 16:44:53 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA-0.94] Fifth test release of Tigon3 driver
Message-ID: <20020304164453.A27587@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020304.041252.13772021.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020304.041252.13772021.davem@redhat.com>; from davem@redhat.com on Mon, Mar 04, 2002 at 04:12:52AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller:
> How does this thing perform for people?  In particular lmbench
> 'bw_tcp' and 'lat_tcp' numbers over gigabit on beefy hardware are
> considered very interesting...

Ok, here I am again; doing some benchmarking :)

(all this is done with same hardware as before, and your tg3 v0.94 driver in
both ends):
test8:/usr/src/LMbench/bin/i686-pc-linux-gnu# ./bw_tcp 129.241.56.160
initial bandwidth measurement: move=10485760, usecs=117352: 89.35 MB/sec
move=693633024, XFERSIZE=65536
Socket bandwidth using 129.241.56.160: 104.73 MB/sec

test8:/usr/src/LMbench/bin/i686-pc-linux-gnu# ./lat_tcp 129.241.56.160
TCP latency using 129.241.56.160: 100.0089 microseconds


Do you want any more benchmark; just say so :)

-- 
Thomas

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281692AbRLKQGQ>; Tue, 11 Dec 2001 11:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281726AbRLKQGI>; Tue, 11 Dec 2001 11:06:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56334 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281692AbRLKQF6>;
	Tue, 11 Dec 2001 11:05:58 -0500
Date: Tue, 11 Dec 2001 17:05:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Paul Larson <plars@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Scsi problems in 2.5.1-pre9
Message-ID: <20011211160543.GZ13498@suse.de>
In-Reply-To: <1008065277.25964.5.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1008065277.25964.5.camel@plars.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11 2001, Paul Larson wrote:
> My hardware is a dual proc PII-300.  I was running LTP runalltests.sh
> and it was on one of the growfiles tests when this problem occurred. 
> The test hung, and I couldn't telnet into the machine or login to it,
> but I could switch between VC's.  On the console, I had screenfulls of
> errors like this:
> 
> Incorrect number of segments after building list
> counted 11, received 7
> req nr_sec 1024, cur_nr_sec 8
> Incorrect number of segments after building list
> counted 14, received 10
> req nr_sec 1024, cur_nr_sec 8
> Incorrect number of segments after building list
> counted 13, received 11
> req nr_sec 584, cur_nr_sec 8
> Incorrect number of segments after building list
> counted 2, received 1
> req nr_sec 16, cur_nr_sec 8
> Incorrect number of segments after building list
> counted 2, received 1
> req nr_sec 16, cur_nr_sec 8
> (scsi0:A:5:0): Locking max tag count at 64
> 
> After doing a hard reboot ext2 made me do a manual fsck, but it seems ok
> now.  I was not able to produce this error in 2.5.1-pre8.

Please don't tell me what hardware you have :-)

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266381AbRHAPAa>; Wed, 1 Aug 2001 11:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267303AbRHAPAV>; Wed, 1 Aug 2001 11:00:21 -0400
Received: from stargate.gnyrf.net ([194.165.254.115]:51074 "HELO
	stargate.gnyrf.net") by vger.kernel.org with SMTP
	id <S266381AbRHAPAK>; Wed, 1 Aug 2001 11:00:10 -0400
To: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: resizing of raid5?
Message-ID: <996685021.3b6834dd0829d@stargate.gnyrf.net>
Date: Wed, 01 Aug 2001 18:57:01 +0200 (CEST)
From: Roger Abrahamsson <hyperion@gnyrf.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <996657922.3b67cb02ba717@stargate.gnyrf.net> <15207.63232.611617.37794@notabene.cse.unsw.edu.au>
In-Reply-To: <15207.63232.611617.37794@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.5
X-Originating-IP: 212.32.163.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Neil Brown <neilb@cse.unsw.edu.au>:

> 
> The only way to resize a raid5 array is to back up, rebuild, and
> re-load.  Any attempt to re-organise the data, or the linkage, to
> avoid this would be more trouble that it is worth.
> 
> NeilBrown

Well, the problem is that it's not that easy when you want to backup say 200GB
of data to find anyone that can hold it for the day while you do it. Well, at
least do it without charge :)
Having things offline for up to a few days while you do the rebuild is okay for
my case, but the offloading the data is not. If I have understood md and raid5,
you create blocks of a fixed size, and calculate the checksum on each "stripe".
To rebuild this looks a bit like disk defragmentation to me, or am I totally
wrong here?

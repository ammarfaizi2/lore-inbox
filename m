Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289124AbSA3MKo>; Wed, 30 Jan 2002 07:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289136AbSA3MKe>; Wed, 30 Jan 2002 07:10:34 -0500
Received: from gatekeeper-s.gts.cz ([194.213.203.154]:18928 "EHLO
	pidaibm.in.idoox.com") by vger.kernel.org with ESMTP
	id <S289124AbSA3MKc>; Wed, 30 Jan 2002 07:10:32 -0500
Date: Wed, 30 Jan 2002 13:10:23 +0100
From: David Hajek <david@atrey.karlin.mff.cuni.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-pre7 Ali chipset performance
Message-ID: <20020130131023.A1332@pidaibm.in.idoox.com>
Reply-To: david@atrey.karlin.mff.cuni.cz
In-Reply-To: <20020130112541.A1215@pidaibm.in.idoox.com> <E16VsGN-0006zA-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16VsGN-0006zA-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 30, 2002 at 10:46:47AM +0000
X-Operating-System: Linux 2.4.18-pre7-ac1
Organization: Systinet, Inc. [formerly Idoox]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002, Alan Cox wrote:
> > I can get around ~8mb/s with hdparm. With 
> > stock 2.4.9-21 redhat kernel I can get 18mb/s, but
> > random lookups occured. 
> 
> I'd be interested to know how 2.4.18pre7-ac1 behaves - that has the newer
> Andre IDE driver work and some other changes that may be relevant. 


Well, this one seems to work correct. I can get around ~18MB/sec,
which seems to me normal. It will be nice to have this in 2.4.18. ;-)
Thanks.


[root@pidaibm david]# hdparm -Tt /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  2.02 seconds = 63.37 MB/sec
 Timing buffered disk reads:  64 MB in  3.49 seconds = 18.34 MB/sec
[root@pidaibm david]# 


-David


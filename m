Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266356AbTATRqF>; Mon, 20 Jan 2003 12:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266363AbTATRqF>; Mon, 20 Jan 2003 12:46:05 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:2802 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S266356AbTATRqE>; Mon, 20 Jan 2003 12:46:04 -0500
Date: Mon, 20 Jan 2003 10:54:47 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: folkert@vanheusden.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: tool for testing how fast your kernel can rename files :-)
Message-ID: <20030120105447.N1594@schatzie.adilger.int>
Mail-Followup-To: folkert@vanheusden.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0301201826120.13207-100000@muur.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0301201826120.13207-100000@muur.intranet.vanheusden.com>; from folkert@vanheusden.com on Mon, Jan 20, 2003 at 06:29:25PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 20, 2003  18:29 +0100, folkert@vanheusden.com wrote:
> This night, while half a-sleep I thought it is usefull to have a tool
> which creates a number of files in a directory and then starts to randomly
> rename them. During this, it should output how much it has done and how
> many renames per second it did.
> 5 minutes back I programmed such a program, you can download it from:
> http://www.vanheusden.com/Linux/rename_test-1.0.tgz
> 
> But now, fully awake with at least 8 cups of coffee in my system I cannot
> think of anything usefull this program is actually doing.
> Well, maybe to test if something gets corrupted allong the way?

For sure correctness is important (we use all sorts of benchmarks like
this to try and exercise our filesystem code), but also performance
measurement is important too.  For example, mailservers do lots of file
renames to push mail through various stages in the delivery pipeline.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUHJIcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUHJIcK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUHJIcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:32:10 -0400
Received: from guardian.hermes.si ([193.77.5.150]:5904 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S261951AbUHJIbv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:31:51 -0400
Message-ID: <B1ECE240295BB146BAF3A94E00F2DBFF090215@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: David Balazic <david.balazic@hermes.si>,
       "'Pat LaVarre'" <p.lavarre@ieee.org>
Cc: linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org
Subject: RE: Can not read UDF CD
Date: Tue, 10 Aug 2004 10:31:36 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I case the torrent does not work, you can also use the "traditional"
http protocol ;-)

http://lizika.pfmb.uni-mb.si/~stein/UDF_image_and_reports/


> ----------
> From: 	Pat LaVarre[SMTP:p.lavarre@ieee.org]
> Sent: 	9. avgust 2004 18:22
> To: 	David Balazic
> Cc: 	linux_udf@hpesjro.fc.hp.com; linux-kernel@vger.kernel.org
> Subject: 	Re: Can not read UDF CD
> 
> > I tried session=0.
> > This gives me the files form the first session, but I can only list 
> > them.
> > I can not see their attributes ( size, permissions etc.. ) or read 
> > them.
> 
> This sounds exactly like the known bug, shared by 2.6.6 and 2.6.5, 
> fixed in 2.6.7, described previously as occurring for UDF discs written 
> to Linux from Windows:
> 
> ls works, but ls -l does not and cd does not.
> 
> > other session=x values fails to mount.
> 
> The dmesg for session=1 might interest us, but in any case, I vote we 
> try reasonably current code e.g. 2.6.7 or a cvs fetch of UDF.
> 
> > I put the ISO image and the udf checker outputs on BitTorrent,
> > the torrent file is avaliable at
> > http://lizika.pfmb.uni-mb.si/~stein/UDF_image_and_reports.torrent
> 
> Excellent, now in theory I can try this myself.
> 
> > In case you don't have a BitTorrent client, one can be had at
> > http://bitconjurer.org/BitTorrent/download.html
> > ( even a commandline version , written in python )
> 
> In practice I am not yet a BitTorrent client, thanks for this clear 
> invitation.
> 
> >> Re: potential bug in udf
> >> ... a new bug ...
> > Upgraded to 2.6.7 - the problem is still there.
> 
> I hear 2.6.7 is by now old enough to have begun collecting known bugs.
> 
> Pat LaVarre
> 

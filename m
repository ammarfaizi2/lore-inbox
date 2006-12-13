Return-Path: <linux-kernel-owner+w=401wt.eu-S964776AbWLMKrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWLMKrO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 05:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWLMKrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 05:47:14 -0500
Received: from plusavs02.SBG.AC.AT ([141.201.10.77]:39282 "HELO
	plusavs02.sbg.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932447AbWLMKrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 05:47:13 -0500
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 05:47:13 EST
Subject: Re: get device from file struct
From: Silviu Craciunas <silviu.craciunas@sbg.ac.at>
Reply-To: silviu.craciunas@sbg.ac.at
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0612131059100.25870@yvahk01.tjqt.qr>
References: <1165850548.30185.18.camel@ThinkPadCK6>
	 <457DA4A0.4060108@ens-lyon.org> <1165914248.30185.41.camel@ThinkPadCK6>
	 <Pine.LNX.4.61.0612131059100.25870@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 11:37:19 +0100
Message-Id: <1166006239.30185.66.camel@ThinkPadCK6>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Dec 2006 10:37:49.0378 (UTC) FILETIME=[BC2A6A20:01C71EA2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 10:59 +0100, Jan Engelhardt wrote:
> >thanks for the reply, the block device can be determined with the major
> >and minor numbers , what I would be more interested in is if one can get
> >the net_device struct from the file struct
> 
> Just how are you supposed to match files and network devices?
> 
> 
> 	-`J'

from the struct file you can get the struct socket and from there to the
struct sock . What I would like to find out is where the data is coming
from (read) and where it is going to(write) or if it is even possible to
find the net device out using the struct file.

Silviu 


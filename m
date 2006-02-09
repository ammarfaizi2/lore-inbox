Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWBIVMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWBIVMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 16:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWBIVMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 16:12:40 -0500
Received: from math.ut.ee ([193.40.36.2]:49403 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1750799AbWBIVMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 16:12:39 -0500
Date: Thu, 9 Feb 2006 23:12:27 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: libATA  PATA status report, new patch
In-Reply-To: <1139499102.1255.45.camel@localhost.localdomain>
Message-ID: <Pine.SOC.4.61.0602092307460.16686@math.ut.ee>
References: <20060207084347.54CD01430C@rhn.tartu-labor> 
 <1139310335.18391.2.camel@localhost.localdomain>  <Pine.SOC.4.61.0602071305310.10491@math.ut.ee>
  <1139312330.18391.14.camel@localhost.localdomain> 
 <1139324653.18391.41.camel@localhost.localdomain>  <Pine.SOC.4.61.0602082024010.21660@math.ut.ee>
 <1139499102.1255.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks: Utterly dumb bug made while converting to the newer refcounting
> PCI API

Yes, it boots now. But reading the disk fails - partition table reading 
bails out. Maybe this is the same early command problem that affects 
other controllers too.

http://www.cs.ut.ee/~mroos/ali1.png
http://www.cs.ut.ee/~mroos/ali2.png

And trying to read the disk from initrd with dd:

http://www.cs.ut.ee/~mroos/ali3.png

-- 
Meelis Roos (mroos@linux.ee)

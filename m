Return-Path: <linux-kernel-owner+w=401wt.eu-S1751145AbXAVMc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbXAVMc4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 07:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXAVMc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 07:32:56 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:39718 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbXAVMcz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 07:32:55 -0500
From: Chr <chunkeey@web.de>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA exceptions with 2.6.20-rc5
Date: Mon, 22 Jan 2007 13:32:51 +0100
User-Agent: KMail/1.9.5
Cc: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, jens.axboe@oracle.com, lwalton@real.com,
       chunkeey@web.de
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <200701212113.22965.chunkeey@web.de> <45B423CB.9020106@gmail.com>
In-Reply-To: <45B423CB.9020106@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701221332.52228.chunkeey@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 22. January 2007 03:39, Tejun Heo wrote:
> Hello,
> 
> Chr wrote:
> > Ok, you won't believe this... I opened my case and rewired my drives... 
> > And guess what, my second (aka the "good") HDD is now failing! 
> > I guess, my mainboard has a (but maybe two, or three :( ) "bad" sata-port(s)!  
> 
> Or, you have power related problem.  Try to rewire the power lines or 
> connect harddrives to a separate powersupply.  It's often useful to 
> change one component at a time and watch which change the problem 
> follows.  Anyways, you seem to be suffering transmission failures, not a 
> driver problem.
> 
> Thanks.
> 

Yes and no, it's probably not a power problem, I've tried another
PSU with the same result :( . Futhermore, the RAID0 setup makes
it impossible to try only one drive alone :(. 

Anyway,the WD2500KS is known to have some strange bugs in the FW.
e.g.: It reports 255°C right after a cold start. 
( http://www.bugtrack.almico.com/view.php?id=468 ).

Thanks,
	Chr.
 

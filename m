Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268832AbUJPUKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268832AbUJPUKI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 16:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268864AbUJPUI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 16:08:59 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:34713 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268832AbUJPUGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 16:06:53 -0400
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: M <mru@mru.ath.cx>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041007143245.GA1698@openzaurus.ucw.cz>
References: <41650CAF.1040901@unimail.com.au>
	 <20041007103210.GA32260@atrey.karlin.mff.cuni.cz>
	 <yw1x7jq2n6k3.fsf@mru.ath.cx>  <20041007143245.GA1698@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1097956343.2148.17.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 16 Oct 2004 15:52:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 10:32, Pavel Machek wrote:
> Hi!
> 
> > >> Is there any way to stop this? I googled around and found it had 
> > >> something to do with idle frequency of 1000 Hz in 2.6 instead of 100Hz 
> > >> in the 2.4 kernel. I couldn't find much else on this. Hunting around the 
> > >> code didn't help much, I don't know C. 
> > >
> > > Change #define HZ 1000 to #define HZ 100...
> > 
> > ... and lose all the benefits of HZ=1000.  
> 
> What benefits? HZ=1000 takes 1W more on my system.
> 

Better timer resolution?

Lee


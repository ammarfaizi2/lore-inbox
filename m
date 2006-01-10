Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030678AbWAJXEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030678AbWAJXEz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030679AbWAJXEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:04:54 -0500
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:37539 "EHLO
	smtpq1.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1030678AbWAJXEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:04:54 -0500
Message-ID: <43C43DC3.4050008@keyaccess.nl>
Date: Wed, 11 Jan 2006 00:05:39 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Jens Axboe <axboe@suse.de>, Sebastian <sebastian_ml@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
References: <20060107115449.GB20748@section_eight.mops.rwth-aachen.de>	 <20060107115947.GY3389@suse.de>	 <20060107140843.GA23699@section_eight.mops.rwth-aachen.de>	 <20060107142201.GC3389@suse.de>	 <20060107160622.GA25918@section_eight.mops.rwth-aachen.de>	 <43BFFE08.70808@wasp.net.au>	 <20060107180211.GA12209@section_eight.mops.rwth-aachen.de>	 <43C00C32.9050002@wasp.net.au> <20060109093025.GO3389@suse.de>	 <20060109094923.GA8373@section_eight.mops.rwth-aachen.de>	 <20060109100322.GP3389@suse.de>  <43C4388B.4060905@keyaccess.nl> <1136933539.2007.88.camel@mindpipe>
In-Reply-To: <1136933539.2007.88.camel@mindpipe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>>One thing that _is_ different is that the SG_IO version very
>>frequently (soft) locks up the machine, with: 
> 
> 
> So you are saying that once you see the BUG: softlockup message the
> system is unresponsive and must be rebooted?

Well, a bit before that -- it takes a while for the softlockup timer to 
trigger. Yes and no, the machine's 'dead' while this is happening but in 
the end (minutes) it does recover in so far that it's no longer trying 
(but does leave around a cdparanoia in D state). Yes, I reboot, and then 
  things work again, until... well, they do not, which is quickly with 
the SG_IO patched cdparanoia.

It's probably more useful to test with a very minimal CDDA extraction 
tool using SG_IO, if Jens has any such tool lying around, and if anyone 
_wants_ me to test. As said, I personally just switched back to using 
regular cdparanoia, which is working fine for me.

Rene.

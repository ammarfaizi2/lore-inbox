Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275092AbRIYQqY>; Tue, 25 Sep 2001 12:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275093AbRIYQqP>; Tue, 25 Sep 2001 12:46:15 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:20720 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S275092AbRIYQqD>; Tue, 25 Sep 2001 12:46:03 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Tue, 25 Sep 2001 10:46:22 -0600
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] OOM aware applications
Message-ID: <20010925104622.B392@turbolinux.com>
Mail-Followup-To: BALBIR SINGH <balbir.singh@wipro.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BB013D3.6060408@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BB013D3.6060408@wipro.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 25, 2001  10:49 +0530, BALBIR SINGH wrote:
> Warning: I am not aware of what was discussed earlier about these issues 
> or if they were discusses at all.

They have been discussed many times.  Please search for SIGDANGER in the
linux-kernel mailing list archive.

> 1. I was wondering that instead of killing the application using 
>    oom_kill_task() directly, should the OOM issue some kind of a
>    warning by sending a signal (some signal with si_code set to a
>    value indicating that the application is causing memory to run
>    out). Then, wait for a while and then see if the application is
>    still misbehaving and if so kill it.

This is exactly what SIGDANGER is.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert


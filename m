Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVDNMmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVDNMmr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 08:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVDNMmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 08:42:47 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:36496 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261492AbVDNMm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 08:42:27 -0400
Date: Thu, 14 Apr 2005 08:42:26 -0400
To: aeriksson@fastmail.fm
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD writer and IDE support...
Message-ID: <20050414124226.GQ521@csclub.uwaterloo.ca>
References: <20050413181421.5C20E240480@latitude.mynet.no-ip.org> <20050413183722.GQ17865@csclub.uwaterloo.ca> <20050413190756.54474240480@latitude.mynet.no-ip.org> <20050413193924.GN521@csclub.uwaterloo.ca> <20050413205949.E987A240480@latitude.mynet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413205949.E987A240480@latitude.mynet.no-ip.org>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 10:59:49PM +0200, aeriksson@fastmail.fm wrote:
> Nope. No go. The kernel log getsb these 4 lines:
> Apr 13 22:08:30 tippex SCSI error : <0 0 0 0> return code = 0x8000002
> Apr 13 22:08:30 tippex sr0: Current: sense key: Medium Error
> Apr 13 22:08:36 tippex SCSI error : <0 0 0 0> return code = 0x8000002
> Apr 13 22:08:36 tippex sr0: Current: sense key: Medium Error
> 
> and the application bails out with:
> :-[ WRITE@LBA=0h failed with SK=5h/ASC=30h/ACQ=05h]: Wrong medium type
> :-( media is not formatted or unsupported.
> :-( write failed: Wrong medium type
> 
> This is with a fresh from the box DVD-RW. Do I need to 'format' the
> thing before writing to it? This is getting tricky... Are these kind
> of errors normally indicative of lack of support or a faulty unit?
> I have no windows around to test it with the shipped nero-cd :-(

What brand/model drive is this?

It is possible to get very weird errors if you have unsupported media in
the drive and some drives don't like certain media types.  Sometimes a
firmware update on the drive fixes it although it usually requires
windows (or sometimes dos) to install the update (or linux will do if
the drive is a plextor).

Len Sorensen

Return-Path: <linux-kernel-owner+w=401wt.eu-S932892AbWLNSts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932892AbWLNSts (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 13:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbWLNSts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 13:49:48 -0500
Received: from brick.kernel.dk ([62.242.22.158]:26864 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932892AbWLNStr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 13:49:47 -0500
Date: Thu, 14 Dec 2006 19:51:12 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Steve Roemen <stever@carlislefsp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iss_storagedev@hp.com,
       mike.miller@hp.com
Subject: Re: 2.6.19-git20 cciss: cmd f7b00000 timedout
Message-ID: <20061214185112.GG5010@kernel.dk>
References: <45819939.3030701@carlislefsp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45819939.3030701@carlislefsp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14 2006, Steve Roemen wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> All,
>     I tried out the 2.6.19-git20 kernel on one of my machines (HP
> DL380 G3) that has the on board 5i controller (disabled),
> 2 smart array 642 controllers.
> 
> I get the error (cciss: cmd f7b00000 timedout) with Buffer I/O error
> on device cciss/c (all cards, and disks) logical block 0, 1, 2, etc

I saw this on another box, but it works on the ones that I have. Does
2.6.19 work? Any chance you can try and narrow down when it broke?

-- 
Jens Axboe


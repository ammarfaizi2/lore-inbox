Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWC1EJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWC1EJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 23:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWC1EJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 23:09:56 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:1705 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750826AbWC1EJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 23:09:56 -0500
Subject: Re: OOM kills if swappiness set to 0, swap storms otherwise
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060327195905.7f666cb5.akpm@osdl.org>
References: <1143510828.1792.353.camel@mindpipe>
	 <20060327195905.7f666cb5.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 23:09:49 -0500
Message-Id: <1143518989.11792.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-27 at 19:59 -0800, Andrew Morton wrote:
> Much porkiness.
> 
> /proc/meminfo is very useful for obtaining a top-level view of where all
> the memory's gone to.  I'd tentatively say that your options are to put up
> with the swapping or find a new mail client.
> 

Thanks.  It seems the problem is Evo (or possibly firefox) has a slow
memory leak.  I overlooked the fact that Evo had been running for more
than a week.

I guess the only possible kernel issue is that Evo never gets
OOM-killed, always Firefox (or OpenOffice if it's running), although
it's the biggest hog.  I'll have to investigate more.

Lee


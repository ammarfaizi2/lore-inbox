Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbTLAVEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 16:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbTLAVEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 16:04:49 -0500
Received: from woozle.fnal.gov ([131.225.9.22]:3987 "EHLO woozle.fnal.gov")
	by vger.kernel.org with ESMTP id S263969AbTLAVAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 16:00:16 -0500
Date: Mon, 01 Dec 2003 15:00:09 -0600
From: Dan Yocum <yocum@fnal.gov>
Subject: Re: XFS for 2.4
In-reply-to: <20031201062052.GA2022@frodo>
To: Nathan Scott <nathans@sgi.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Message-id: <3FCBABD9.70309@fnal.gov>
Organization: Fermilab
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
References: <20031201062052.GA2022@frodo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

We (Fermilab) second this request.  We won't be touching 2.6 until it's 
really stable (read as, Red Hat comes out with an official distro that has 
it built in), and we already have *a lot* of XFS filesystems here (~>300TB) 
running on 2.4 kernels.  It would be very, very nice to have it in the 2.4 
tree without having to pull it from SGI.

Thanks,
Dan


Nathan Scott wrote:
> Hi Marcelo,
> 
> Please do a
> 
> 	bk pull http://xfs.org:8090/linux-2.4+coreXFS
> 
> This will merge the core 2.4 kernel changes required for supporting
> the XFS filesystem, as listed below.  If this all looks acceptable,
> then please also pull the filesystem-specific code (fs/xfs/*)
> 
> 	bk pull http://xfs.org:8090/linux-2.4+justXFS
> 
> cheers.
> 

-- 
Dan Yocum
Sloan Digital Sky Survey, Fermilab  630.840.6509
yocum@fnal.gov, http://www.sdss.org
SDSS.  Mapping the Universe.  You are here.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbTIBFsb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 01:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263560AbTIBFsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 01:48:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39554 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263497AbTIBFsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 01:48:30 -0400
Date: Tue, 2 Sep 2003 07:48:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CFQ scheduler leaves task in D state
Message-ID: <20030902054824.GK30058@suse.de>
References: <E19tufw-0008QV-00@laibach.mweb.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19tufw-0008QV-00@laibach.mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01 2003, Bongani Hlope wrote:
> Hi
> 
> I tried the CFQ scheduler patch you posted on top of 2.6.0-test4-mm3-1, 
> including the O19int patch from Con Kolivas and I got the attached stacktrace.

Thanks Bongani, I reproduced this problem yesterday. I'll post an update
later today. There appears to be a missing last_merge clear somewhere,
odd.

-- 
Jens Axboe


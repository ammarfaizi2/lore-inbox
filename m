Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTDGR2J (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 13:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263572AbTDGR2J (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 13:28:09 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:33629 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263571AbTDGR2I (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 13:28:08 -0400
Message-ID: <3E91B7D3.30108@RedHat.com>
Date: Mon, 07 Apr 2003 13:39:31 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] [PATCH] mmap corruption
References: <3E8DDB13.9020009@RedHat.com>	<shsistt7wip.fsf@charged.uio.no>	<20030405164741.GA6450@RedHat.com>	<16016.7633.982870.860147@charged.uio.no>	<20030407140052.GA1471@RedHat.com> <16017.37263.648356.201846@charged.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Trond Myklebust wrote:

>However, I still stand by my statement that nfs_wb_all() is supposed
>to ensure that *all* pending writes have been cleared.
>The only explanation for npages != 0 is if
>
>  a) an error occurred with nfs_wb_all() (we should perhaps test the
>     return value of nfs_wb_all() there). Under normal circumstances,
>     an error should only occur if you're using soft mounts, though.
>
I have checked the return value and its not failing... The would be too 
easy... :-)

SteveD.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbWHAJ5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWHAJ5I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbWHAJ5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:57:08 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:1031 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932597AbWHAJ5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:57:07 -0400
Message-ID: <44CF256F.1020605@argo.co.il>
Date: Tue, 01 Aug 2006 12:57:03 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Adrian Ulrich <reiser4@blinkenlights.ch>, nate.diller@gmail.com,
       dlang@digitalinsight.com, vonbrand@inf.utfsm.cl, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view"
 expressed by kernelnewbies.org regarding reiser4 inclusion]
References: <20060801090947.GA2974@merlin.emma.line.org>
In-Reply-To: <20060801090947.GA2974@merlin.emma.line.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Aug 2006 09:57:05.0987 (UTC) FILETIME=[D8700930:01C6B550]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
>
> No, it is valid to run the test on commodity hardware, but if you (or
> the benchmark rather) is claiming "transactions", I tend to think
> "ACID", and I highly doubt any 200 GB SATA drive manages 3000
> synchronous writes per second without causing either serious
> fragmentation or background block moving.
>
You are assuming 1 transaction = 1 sync write.  That's not true.  
Databases and log filesystems can get much more out of a disk write.


-- 
error compiling committee.c: too many arguments to function


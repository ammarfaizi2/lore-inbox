Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266639AbUGVIVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266639AbUGVIVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 04:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266805AbUGVIVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 04:21:46 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:62932 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S266639AbUGVIVp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 04:21:45 -0400
In-Reply-To: <200407211607.11915.jbarnes@engr.sgi.com>
References: <20040721091249.GA1336@suse.de> <1090421466.2002.24.camel@gaston> <200407211607.11915.jbarnes@engr.sgi.com>
Mime-Version: 1.0 (Apple Message framework v618)
Message-Id: <3156F76B-DBB8-11D8-9237-000A95A4DC02@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackeras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: reserve legacy io regions on powermac
Date: Thu, 22 Jul 2004 10:21:55 +0200
To: Jesse Barnes <jbarnes@engr.sgi.com>
X-Mailer: Apple Mail (2.618)
X-MIMETrack: Itemize by SMTP Server on D12ML064/12/M/IBM(Release 6.0.2CF2HF259 | March
 11, 2004) at 22/07/2004 10:21:10,
	Serialize by Router on D12ML064/12/M/IBM(Release 6.0.2CF2HF259 | March 11, 2004) at
 22/07/2004 10:21:11,
	Serialize complete at 22/07/2004 10:21:11
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Note that this is still all workarounds... Nothing prevents you (and 
>> some
>> people actually do that) to put a PCI card with legacy serial ports 
>> on it
>> inside a pmac....
>
> Can you actually support this?  Will it work?

It works fine with Darwin, so it should work with Linux, too...

I don't know if Linux likes to have a device sit at I/O address
0x0 -- this might give some problems.


Segher


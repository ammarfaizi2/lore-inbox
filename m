Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030544AbWJ3RVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030544AbWJ3RVu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965358AbWJ3RVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:21:50 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:14 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S965357AbWJ3RVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:21:49 -0500
Message-ID: <45463481.80601@shadowen.org>
Date: Mon, 30 Oct 2006 17:21:05 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
References: <20061029160002.29bb2ea1.akpm@osdl.org>	<45461977.3020201@shadowen.org>	<45461E74.1040408@google.com> <20061030084722.ea834a08.akpm@osdl.org> <454631C1.5010003@google.com>
In-Reply-To: <454631C1.5010003@google.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
>>> Setting up network interfaces:
>>>      lo
>>>     lo        IP address: 127.0.0.1/8
>>> 7[?25l[1A[80C[10D[1;32mdone[m8[?25h    eth0
>>>               No configuration found for eth0
>>> 7[?25l[1A[80C[10D[1munused[m8[?25h    eth1
>>>             No configuration found for eth1
>>>
>>> for all 8 cards.
>>
>>
>> What version of udev is being used?
> 
> Buggered if I know. If we could quit breaking it, that'd be good though.
> If it printed its version during boot somewhere, that'd help too.
> 
>> Was CONFIG_SYSFS_DEPRECATED set?
> 
> No.
> 
> M.

These all sounds pretty old.  I'll rerun them all with
CONFIG_SYSFS_DEPRECATED set and see what pans out.

-apw

elm3b239:~ # udevinfo -V
udevinfo, version 085
elm3b239:~ #

gekko-lp1:~ # udevinfo -V
udevinfo, version 021_bk
gekko-lp1:~ #

bucket:~ # udevinfo -V
udevinfo, version 021_bk
bucket:~ #

el9-92-101:~ # udevinfo -V
udevinfo, version 021_bk
el9-92-101:~ #

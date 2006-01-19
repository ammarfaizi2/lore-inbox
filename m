Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422649AbWASX1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbWASX1L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 18:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422672AbWASX1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 18:27:11 -0500
Received: from host233.omnispring.com ([69.44.168.233]:16658 "EHLO
	iradimed.com") by vger.kernel.org with ESMTP id S1422649AbWASX1J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 18:27:09 -0500
Message-ID: <43D02033.4070008@cfl.rr.com>
Date: Thu, 19 Jan 2006 18:26:43 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
References: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com> <Pine.LNX.4.61.0601181427090.19392@yvahk01.tjqt.qr> <17358.52476.290687.858954@cse.unsw.edu.au> <43D00FFA.1040401@cfl.rr.com> <17360.5011.975665.371008@cse.unsw.edu.au>
In-Reply-To: <17360.5011.975665.371008@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jan 2006 23:28:01.0948 (UTC) FILETIME=[FD82FDC0:01C61D4F]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.51.1032-14216.000
X-TM-AS-Result: No--7.900000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> The in-kernel autodetection in md is purely legacy support as far as I
> am concerned.  md does volume detection in user space via 'mdadm'.
> 
> What other "things like" were you thinking of.
> 

Oh, I suppose that's true.  Well, another thing is your new mods to 
support on the fly reshaping, which dm could do from user space.  Then 
of course, there's multipath and snapshots and other lvm things which 
you need dm for, so why use both when one will do?  That's my take on it.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945928AbWBCTro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945928AbWBCTro (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945929AbWBCTro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:47:44 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:54801 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1945925AbWBCTrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:47:43 -0500
Message-ID: <43E3B32C.2080806@cfl.rr.com>
Date: Fri, 03 Feb 2006 14:46:52 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
CC: Martin Drab <drab@kepler.fjfi.cvut.cz>, Bill Davidsen <davidsen@tmr.com>,
       Cynbe ru Taren <cynbe@muq.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F0217F765@otce2k03.adaptec.com>
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F0217F765@otce2k03.adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Feb 2006 19:48:17.0098 (UTC) FILETIME=[C6ECCAA0:01C628FA]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14245.000
X-TM-AS-Result: No--1.300000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salyzyn, Mark wrote:
> The drive is low level formatted. This resolved the problem you were
> having.
>
>   

Could you define what you mean by "low level format"?  AFAIK, IDE drives 
do not provide a command to low level format them ( like MFM and RLL 
drives required ), so the best you can do is write zeroes to all sectors 
on the disk. 



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWHHGhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWHHGhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWHHGhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:37:04 -0400
Received: from mms2.broadcom.com ([216.31.210.18]:64784 "EHLO
	mms2.broadcom.com") by vger.kernel.org with ESMTP id S1751249AbWHHGhD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:37:03 -0400
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
Date: Mon, 7 Aug 2006 23:36:50 -0700
Message-ID: <1551EAE59135BE47B544934E30FC4FC093FA21@NT-IRVA-0751.brcm.ad.broadcom.com>
In-Reply-To: <20060805202603.GA9740@thunk.org>
Thread-Topic: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
thread-index: Aca4zW2mkiRsVjPlSEKe32T4tlc4xgB5OXlA
From: "Michael Chan" <mchan@broadcom.com>
To: "Theodore Tso" <tytso@mit.edu>
cc: "David Miller" <davem@davemloft.net>, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006080801; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230322E34344438333036462E303032372D422D2F342B574C684A754433704B705975633943514C71513D3D;
 ENG=IBF; TS=20060808063657; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006080801_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 68C6EE8D0X82028301-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:

> Thanks, that description was very helpful.  Would you accept a patch
> with adding a comment describing this?

I will put it on my queue to add some comments for ASF.

> 
> It appears that there is no way of disabling ASF; is that a true
> statement?
> 

Turning off ASF is just a matter of changing some bits in NVRAM
and recalculating the checksum.  If you need the tool to do this,
I'll have someone send it to you.

Note that on some of the blade servers, I believe ASF is vital
and should not be disabled.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264780AbUEUVKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264780AbUEUVKs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 17:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUEUVKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 17:10:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36062 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264780AbUEUVKq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 17:10:46 -0400
Message-ID: <40AE7049.80900@pobox.com>
Date: Fri, 21 May 2004 17:10:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Don Fry <brazilnut@us.ibm.com>
CC: tsbogend@alpha.franken.de, netdev@oss.sgi.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] 2.4.27-pre3 pcnet32.c
References: <200405212055.i4LKtx110244@DYN318364BLD.beaverton.ibm.com>
In-Reply-To: <200405212055.i4LKtx110244@DYN318364BLD.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Fry wrote:
> Please apply the following patches to 2.4.27-pre3.  The first four are simple
> "one line" fixes. The last removes the timer I added a little while ago,
> as it added complexity without improving performance.
> 
> [PATCH 1/5] 2.4.27-pre3 pcnet32 add static to two routines.
> [PATCH 2/5] 2.4.27-pre3 pcnet32 avoid hard hang with some chip variants.
> [PATCH 3/5] 2.4.27-pre3 pcnet32 correct 79C976 variant string.
> [PATCH 4/5] 2.4.27-pre3 pcnet32 fix boundary comparison bug.
> [PATCH 5/5] 2.4.27-pre3 pcnet32 remove timer and complexity.


It would help me a lot if you changed your email subject line in two 
minor ways:

1) Include the kernel version _inside_ the brackets,

	[PATCH 1/5 2.4.27-pre3]

2) Just to make it look a tad nicer and more consistent with other 
changelog entries, add a colon after the driver name:

	[PATCH 1/5 2.6.6] pcnet32: mark two routines static

This allows me to pass your submission fully automated through scripts. 
  The resultant one-line description of your patch becomes

	[PATCH] pcnet32: mark two routines static

when my scripts merge your patch into the BK repository.

BTW, you don't need to resend your 2.4 and 2.6 pcnet32 patches, this is 
just for future reference.

	Jeff


P.S.  Somebody should put this into Documentation/SubmittingPatches...


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbVCJRSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbVCJRSW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbVCJRPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:15:36 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:62634 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262731AbVCJRFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:05:24 -0500
Message-ID: <42307E4D.6080505@ca.ibm.com>
Date: Thu, 10 Mar 2005 11:05:17 -0600
From: Omkhar Arasaratnam <iamroot@ca.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Matthew Wilcox <matthew@wil.cx>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, tgall@us.ibm.com,
       antonb@au1.ibm.com
Subject: Re: [BUG] 2.6.11- sym53c8xx Broken on pp64
References: <422FA817.4060400@ca.ibm.com>	 <1110420620.32525.145.camel@gaston> <422FBACF.90108@ca.ibm.com>	 <422FC042.40303@ca.ibm.com>	 <Pine.LNX.4.58.0503091944030.2530@ppc970.osdl.org>	 <1110434383.32525.184.camel@gaston>	 <20050310121701.GD21986@parcelfarce.linux.theplanet.co.uk> <1110467868.5379.15.camel@mulgrave>
In-Reply-To: <1110467868.5379.15.camel@mulgrave>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>On Thu, 2005-03-10 at 12:17 +0000, Matthew Wilcox wrote:
>  
>
>>Heh, the devel version of sym2 (that isn't submitted yet because
>>it depends on a few changes to the SPI transport that James hasn't
>>integrated yet) would probably fix this as it doesn't call iounmap()
>>until the driver exits.
>>    
>>
>
>They're integrated into the scsi-misc-2.6 tree, so if you send in the
>sym2 patch to linux-scsi, everything should still work...
>
>James
>
>
>
>  
>
2.6.10 seems to have a different kernel panic which I'm investigating 
(could be a problem with my ramdisk as it happens in my linuxrc). So 
long story short the 2.6.10 sym driver looks ok.

Omkhar


Return-Path: <linux-kernel-owner+w=401wt.eu-S965065AbXASPFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbXASPFi (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 10:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbXASPFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 10:05:37 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:2665 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965065AbXASPFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 10:05:37 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA exceptions with 2.6.20-rc5
Date: Fri, 19 Jan 2007 15:05:33 +0000
User-Agent: KMail/1.9.5
Cc: Robert Hancock <hancockr@shaw.ca>,
       =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <45AC1DA3.5040104@shaw.ca> <45AC3006.9070705@garzik.org>
In-Reply-To: <45AC3006.9070705@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701191505.33480.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 January 2007 01:53, Jeff Garzik wrote:
> Robert Hancock wrote:
> > I'll try your stress test when I get a chance, but I doubt I'll run into
> > the same problem and I haven't seen any similar reports. Perhaps it's
> > some kind of wierd timing issue or incompatibility between the
> > controller and that drive when running in ADMA mode? I seem to remember
> > various reports of issues with certain Maxtor drives and some nForce
> > SATA controllers under Windows at least..
>
> Just to eliminate things, has disabling ADMA been attempted?
>
> It can be disabled using the sata_nv.adma module parameter.

Setting this option fixes the problem for me. I suggest that ADMA defaults off 
in 2.6.20, if there's still time to do that.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

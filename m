Return-Path: <linux-kernel-owner+w=401wt.eu-S932204AbXAPBxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbXAPBxO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 20:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbXAPBxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 20:53:14 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:51591 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932204AbXAPBxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 20:53:13 -0500
Message-ID: <45AC3006.9070705@garzik.org>
Date: Mon, 15 Jan 2007 20:53:10 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrin?= =?ISO-8859-1?Q?k?= 
	<B.Steinbrink@gmx.de>
CC: linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com
Subject: Re: SATA exceptions with 2.6.20-rc5
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <45AAC039.1020808@shaw.ca> <20070115211723.GA3750@atjola.homenet> <20070115234650.GA2124@atjola.homenet> <45AC1DA3.5040104@shaw.ca>
In-Reply-To: <45AC1DA3.5040104@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> I'll try your stress test when I get a chance, but I doubt I'll run into 
> the same problem and I haven't seen any similar reports. Perhaps it's 
> some kind of wierd timing issue or incompatibility between the 
> controller and that drive when running in ADMA mode? I seem to remember 
> various reports of issues with certain Maxtor drives and some nForce 
> SATA controllers under Windows at least..


Just to eliminate things, has disabling ADMA been attempted?

It can be disabled using the sata_nv.adma module parameter.

	Jeff



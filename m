Return-Path: <linux-kernel-owner+w=401wt.eu-S1751884AbXAVCq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbXAVCq3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 21:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbXAVCq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 21:46:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:4162 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbXAVCq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 21:46:28 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Qfz0b/LpriktTG7Dt3Jb5NG3leETOjlhXfMveC1HyvqEytFLJKctoNfBeBYT6/WmEWYx4DZJtfJ1VbHE+HI4h8H3a3Z6+t5gFRiFMyeuuos6qJUNnuayeBBxrcN4LGbHml3WuA5Tv340SYQDbu4tsDReOYW7VWaRfnU964BnCTQ=
Message-ID: <45B42569.6030902@gmail.com>
Date: Mon, 22 Jan 2007 11:46:01 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Paolo Ornati <ornati@fastwebnet.it>
CC: Robert Hancock <hancockr@shaw.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA exceptions triggered by XFS (since 2.6.18)
References: <20070121152932.6dc1d9fb@localhost>	<20070121174023.68402ade@localhost>	<45B3A392.6050609@shaw.ca> <20070121202552.14cc29fe@localhost>
In-Reply-To: <20070121202552.14cc29fe@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:
> I don't know. It's a two years old ST380817AS.
> 
> # smartctl -a -d ata /dev/sda
> 
> smartctl version 5.36 [x86_64-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
> 
> === START OF INFORMATION SECTION ===
> Model Family:     Seagate Barracuda 7200.7 and 7200.7 Plus family
> Device Model:     ST380817AS

I'll blacklist it.  Thanks.

-- 
tejun

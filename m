Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWHONft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWHONft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 09:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWHONfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 09:35:48 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:48723 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030286AbWHONfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 09:35:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ODTnC8VYP2nPCXAzLhII96SQwxnLyUpyF+XgvZ4WkmrWpby72gEPmLtVR7WBogO+5bIRrxzgN4mSq3Ge0Js+EX7INQ863GvZ3mtOFQzFiRqzwr+/c26DaWYudc/xH3JCZLRkZahJEfOc3o2aZMPp2x+dTI4swJtd3gIoPdRIT9o=
Message-ID: <44E1CDAE.7000203@gmail.com>
Date: Tue, 15 Aug 2006 22:35:42 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Matthieu CASTET <castet.matthieu@free.fr>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Merging libata PATA support into the base kernel
References: <1155144599.5729.226.camel@localhost.localdomain>	<44DA4288.6020806@rtr.ca> <44DACE9F.3090909@garzik.org>	<44DCA67B.5070400@rtr.ca> <ebsibq$qgb$1@sea.gmane.org>
In-Reply-To: <ebsibq$qgb$1@sea.gmane.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthieu CASTET wrote:
> Hi,
> 
> On Fri, 11 Aug 2006 11:47:07 -0400, Mark Lord wrote:
> 
>> And libata already has sufficient ioctl compatibility for nearly all
>> purposes with the old drivers/ide stuff.  Yes, there are some more
>> esoteric ioctls that I once implemented in drivers/ide that do not
>> exist for libata, and nobody will miss them.
> IRRC, there nothing for ATAPI ioctl compatibility, there only things for
> ATA.

What do you mean by ATAPI ioctl - TASK or TASKFILE ioctl or something else?

-- 
tejun

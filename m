Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUAWX5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 18:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266788AbUAWX5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 18:57:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17598 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266775AbUAWX5J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 18:57:09 -0500
Message-ID: <4011B4C8.50908@pobox.com>
Date: Fri, 23 Jan 2004 18:56:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mgabriel@ecology.uni-kiel.de
CC: linux-kernel@vger.kernel.org
Subject: Re: vt6410 in kernel 2.6
References: <200401222238.09157.mgabriel@ecology.uni-kiel.de> <4011AE4C.5050408@pobox.com> <200401240047.19261.mgabriel@ecology.uni-kiel.de>
In-Reply-To: <200401240047.19261.mgabriel@ecology.uni-kiel.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Gabriel wrote:
> hi jeff,
> 
> 
>>>is there any chance of upcoming support for the vt6410 ide/raid chipset
>>>in the 2.6.x kernel? there has been an attempt by via itself, but it only
>>>suits redhat 7.2 kernels and systems, thus it is highly specific. is
>>>there any1 who is working on that?
>>
>>It should already be in there.
> 
> 
> can you tell me the exact kernel-config-option or the menuconfig line? i have 
> looked for it and couldn't find it. also most of the google hits were 
> negative. there weren't many, either.


CONFIG_BLK_DEV_GENERIC or CONFIG_SCSI_SATA_VIA should do it.

	Jeff




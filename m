Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271090AbTGXFVC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 01:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271101AbTGXFVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 01:21:02 -0400
Received: from user145.net484.nc.sprint-hsd.net ([65.40.169.145]:47241 "EHLO
	mail1.lvwnet.com") by vger.kernel.org with ESMTP id S271090AbTGXFU7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 01:20:59 -0400
Message-ID: <3F1F7046.7080009@lvwnet.com>
Date: Thu, 24 Jul 2003 01:36:06 -0400
From: Vinnie <listacct1@lvwnet.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Philippe Troin <phil@fifi.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 (and newer) - prob with the new adaptec aic7xxx driver
 and Promise UltraTrak100 TX2
References: <3F1F5397.8000001@lvwnet.com> <87ispsd229.fsf@ceramic.fifi.org>
In-Reply-To: <87ispsd229.fsf@ceramic.fifi.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Troin wrote:
>>
>>If I compile the kernel to use the NEW aic7xxx adaptec driver, the
>>SCSI bus hangs almost immediately upon commencement of a large write
>>operation, such as attempting to copy a 500MB file from one of the
>>internal client machines to a SMB shared directory on this server.
>>The problem is reproducible on 2.4.19 and 2.4.20 kernels, if I use the
>>"new" aic7xxx driver.
> 
> 
> 8< snip >8
> 
> Have you tried the updated aic7xxx driver at
> http://people.freebsd.org/~gibbs/linux/SRC/ ?
> 
> AFAIK it fixes a lot of problems with aic7xxx and was not included in
> 2.4.21 for technicalities.

Hi Phil,

Thanks Phil - the updated driver solved my problem, I am now happily up and 
running (and doing big writes without problems) on a fresh-compiled 2.4.20 
kernel, with the /drivers/scsi tree patched with the latest set of Justin 
Gibbs' drivers (6.2.36)

Thanks to Justin also, and everybody else who has (no doubt) worked on the 
new Adaptec drivers to improve it since the versions included with the 
official kernel.org 2.4.19 and 2.4.20 kernel sources.

Vinnie


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVLBLE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVLBLE4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 06:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbVLBLE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 06:04:56 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:17850 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932237AbVLBLEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 06:04:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Zx0dFRa5IAiAVjZcjEUHUp5PfYZEFxlHy/g3ZgSd9gDlJRMlE3vi6xCt31kuUpuEuoSwATNS3WzA+nB3Ctv/zXcIsDAgSaSdy+uxFz09USMy3fRKEdpZhsVsfUkblnL3WXMqDSEvRtYLipCv1e9Djg27EEURavqu2sOej0XYU/A=
Message-ID: <43902A52.9040909@gmail.com>
Date: Fri, 02 Dec 2005 20:04:50 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yanggun <yang.geum.seok@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 + SATAII150 TX2Plus does not recognize
References: <ee0ae26a0512020039k1a28da61y@mail.gmail.com>
In-Reply-To: <ee0ae26a0512020039k1a28da61y@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yanggun wrote:
> Hi,
> 
> i am currently using linux kernel version 2.6.14 on x86 with Promise
> SATAII150 TX2Plus(250G SATA HDD Disk x 2).
> 
> But, SATA HDD disk does not become. program execute result of "fdisk
> /dev/sda" is  "Unable to read /dev/sda".
> 
> Work well in linux kernel version 2.6.13.2.
> 
> Do not act below since change as result that do debugging.
>        "[SCSI] use scatter lists for all block pc requests and
> simplify hw handlers"
>        -  http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=392160335c798bbe94ab3aae6ea0c85d32b81bbc
> 
> What should I do?
> 

Your controller is probably supported by sata_promise driver included in 
the kernel.  Just use the standard driver.

-- 
tejun

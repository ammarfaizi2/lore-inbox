Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVDBOHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVDBOHv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 09:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVDBOHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 09:07:51 -0500
Received: from relay01.pair.com ([209.68.5.15]:34321 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S261475AbVDBOHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 09:07:43 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <424EA73C.1090300@cybsft.com>
Date: Sat, 02 Apr 2005 08:07:56 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc1 won't boot if SCSI drivers are selected as modules
References: <424D3BDD.5010001@cybsft.com> <9e47339105040118312ba5b356@mail.gmail.com>
In-Reply-To: <9e47339105040118312ba5b356@mail.gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On Apr 1, 2005 7:17 AM, K.R. Foley <kr@cybsft.com> wrote:
> 
>>I have an old Dell Precision 620 workstation with dual PIII 933's and
>>512 Mb memory. It also uses AIC-7899P U160/m SCSI controllers with one
>>U160 drive (boot drive) and one slower 18 Gb. I have been running many
>>different variants of the kernel on this system for quite some time with
>>much success. However, no amount of gnashing of teeth or pulling of hair
>>have been able to get this system to boot ANY 2.6.12-rc1 (including
>>2.6.12-rc1 vanilla, 2.6.12-rc1-mm3 and various RT patches) variant when
>>the SCSI drivers are selected as modules (which is the way that I have
>>always done it). Last night I built all of the necessary drivers into
>>the kernel and the system boots fine.
> 
> 
> I am also seeing this but not on every boot. My work around is to add
> a 'sleep 2' to the nash script after the modules are loaded. Compling
> everything in also worked.

I will give this a try. Although I did compare the init from a working 
initrd with the init from a non-working initrd, with no differences :-/

> 
> This is discussed in the thread: "current linus bk, error mounting
> root". I believe the answer is that it is not a kernel problem,
> instead the init scripts have to be fixed.
> 
I figured it probably had been discussed if anyone else was having this 
problem, it's just that I have been pretty scarce in the last couple of 
weeks. I did try searching the archives but that didn't produce any 
help. ;-) I will go back and take a look at this thread.

Thanks much.

-- 
    kr

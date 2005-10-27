Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVJ0OU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVJ0OU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 10:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVJ0OU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 10:20:59 -0400
Received: from smtp.preteco.com ([200.68.93.225]:40685 "EHLO smtp.preteco.com")
	by vger.kernel.org with ESMTP id S1750797AbVJ0OU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 10:20:58 -0400
Message-ID: <4360E217.7000700@rhla.com>
Date: Thu, 27 Oct 2005 12:20:07 -0200
From: =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@rhla.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Panic + Intel SATA
References: <435FC886.7070105@rhla.com>	 <Pine.LNX.4.61.0510261523350.6174@chaos.analogic.com>	 <4360261E.4010202@rhla.com> <436026F2.1030206@rhla.com>	 <Pine.LNX.4.61.0510270839130.9512@chaos.analogic.com> <1130420072.10604.37.camel@localhost.localdomain>
In-Reply-To: <1130420072.10604.37.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Iau, 2005-10-27 at 08:49 -0400, linux-os (Dick Johnson) wrote:
>  
>
>>This is all 'Fedora' stuff, not Linux stuff. You should upgrade
>>your 'mkinitrd' (or rewrite it) so it doesn't use Fedora-specific
>>stuff if you intend to install an un-patched kernel.
>>    
>>
>
>Fedora is quite happy with an unpatched kernel, that is generally what I
>am running for development on Fedora.
>  
>
When I copiled the src fedora core 4 kernel 
(kernel-2.6.12-1.1456_FC4.src.rpm and kernel-2.6.13-1.1526_FC4.src.rpm), 
I got the same error messages.

>If you are using LVM2 or MD you just need to be sure you have the right
>config options enabled (the Red Hat src.rpm is a good guide).
>
>Alan
>  
>
I'm not using lvm or raid in the /root or the /boot partition. All 
partitions was made directly in the disk and formated with ext3 file 
system. I think all needed options was compiled in the new kernel, since 
I copied the /boot/config-2.6.12-1.1456_FC4 (config file from the kernel 
that works fine) and compiled the kernel.src.rpm without any 
modifications in the config file, and it still not working.

Any more ideas?

Thank you Alan.
Márcio Oliveira.

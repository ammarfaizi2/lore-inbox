Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUAJQVk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 11:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUAJQVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 11:21:39 -0500
Received: from [216.127.68.117] ([216.127.68.117]:5522 "HELO 216.127.68.117")
	by vger.kernel.org with SMTP id S265245AbUAJQTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 11:19:54 -0500
Message-ID: <40002620.2060205@meerkatsoft.com>
Date: Sun, 11 Jan 2004 01:19:44 +0900
From: Alex <alex@meerkatsoft.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Christian Kivalo <valo@valo.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: Cannot boot after new Kernel Build
References: <NMEHJKFGFEGJPIPOLFFEIEBEDEAA.valo@valo.at>
In-Reply-To: <NMEHJKFGFEGJPIPOLFFEIEBEDEAA.valo@valo.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
yes I already tried /dev/hda3 but still get the same errors when booting.

Alex

Christian Kivalo wrote:

>>Hi,
>>I tried changing the fstab, removing the LABLE from the grub.conf,
>>removing initrd from it and also tried to boot with
>>/dev/hda3.  Nothing
>>works, still the same problem.
>>    
>>
>
>hi!
>
>you don't have to change your fstab, there should everything ok with you
>fstab.
>
>you should change the root= entry in your grub configuration to your
>actual root partition. if you don't know what partition your root is on,
>do a 'df' and look where '/' is mounted on.
>
>the second line of df output should read somewhat similar to:
>/dev/sda2              4806936   1611232   2951516  36% /
>
>that's my fileserver where /dev/sda2 is mounted as '/'.
>
>your root= in grub config should read somewhat like this:
>root=/dev/hda1)
>
>hth
>christian
>
>  
>
>>Alex
>>
>>    
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>



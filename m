Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVAJWux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVAJWux (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVAJWrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:47:42 -0500
Received: from gw.unix-scripts.info ([62.212.121.13]:48596 "EHLO
	gw.unix-scripts.info") by vger.kernel.org with ESMTP
	id S262555AbVAJWmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:42:09 -0500
Message-ID: <41E304BA.7030404@apartia.fr>
Date: Mon, 10 Jan 2005 23:42:02 +0100
From: Laurent CARON <lcaron@apartia.fr>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to burn DVDs
References: <41E2F823.1070608@apartia.fr> <20050110222926.GA17865@csclub.uwaterloo.ca>
In-Reply-To: <20050110222926.GA17865@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:

>On Mon, Jan 10, 2005 at 10:48:19PM +0100, Laurent CARON wrote:
>  
>
>>I recently upgraded to 2.6.10 and tried (today) to burn a dvd with 
>>growisofs.
>>
>>It seems there is a problem
>>
>>Here is the output
>>
>>
>># growisofs -Z /dev/scd0 -R -J ~/foobar
>>
>>WARNING: /dev/scd0 already carries isofs!
>>About to execute 'mkisofs -R -J /root/sendmail.mc | builtin_dd 
>>of=/dev/scd0 obs=32k seek=0'
>>INFO:ingISO-8859-15 character encoding detected by locale settings.
>>       Assuming ISO-8859-15 encoded filenames on source filesystem,
>>       use -input-charset to override.
>>Total translation table size: 0
>>Total rockridge attributes bytes: 252
>>Total directory bytes: 0
>>Path table size(bytes): 10
>>/dev/scd0: "Current Write Speed" is 4.1x1385KBps.
>>:-[ WRITE@LBA=0h failed with SK=4h/ASC=08h/ACQ=03h]: Input/output error
>>:-( write failed: Input/output error
>>
>>
>>Needless to say it works fine with 2.6.9
>>
>>Am I missing something?
>>    
>>
>
>Is it actually a scsi device?
>
>I haven't tried myself with 2.6.10 yet, but with 2.6.9 and older I have
>just used /dev/hda to access my dvd writer.  Seemed much better than
>ide-scsi at least.  Of course if it is usb or firewire I guess the scsi
>interface is required.
>
>Len Sorensen
>  
>
It is an internal IDE drive (laptop)

Same when using /dev/hdc or /dev/scd0

Laurent

-- 
  Why don't you pair `em up in threes? -Yogi Berra


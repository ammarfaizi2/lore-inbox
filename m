Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbUL3JJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbUL3JJw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 04:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbUL3JIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 04:08:39 -0500
Received: from www.pcextreme.nl ([213.189.21.112]:9896 "HELO mail.pcextreme.nl")
	by vger.kernel.org with SMTP id S261581AbUL3I5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:57:24 -0500
X-Antivirus-PCextreme-Mail-From: iwan.sanders@tuxproject.info via mail.pcextreme.nl
X-Antivirus-PCextreme: 1.22-st-qms (Clear:RC:0(212.26.213.3):SA:0(-4.9/5.0):. Processed in 1.478693 secs Process 6648)
Message-ID: <41D3C2EA.2020206@tuxproject.info>
Date: Thu, 30 Dec 2004 09:57:14 +0100
From: Iwan Sanders <iwan.sanders@tuxproject.info>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kevin Krieser <kkrieser@lcisp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: What kernel versions will allow files larger than 4 GB?]
References: <20041230011239.F24D310E984@suse9.kkrieser.homelinux.org>
In-Reply-To: <20041230011239.F24D310E984@suse9.kkrieser.homelinux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Krieser wrote:

Hi Kevin, thanks for replying!

>There was support for large files back in the 2.2 days.
>  
>
Do you happen to know how large the maximum file size was then? Are 
there some kernel specifications I can look into,
also for the more recent kernels?

>And ext2 and 3 have supported it for quite some time.
>  
>
I thought that the maximum file size a file system can handle is 
independent of the maximum file size the kernel can handle?

>The big issues after kernel support was GLIBC support.  And even with GLIBC
>support, the application needs to be compiled with explicit large file
>support.  Main reason it isn't the default is to avoid bugs.  Just think of
>applications that use read/seek/write, etc.  If they just used int for
>offsets, etc, they would break on large files, which is why extra calls were
>made to support large files.
>  
>
Going to look into the GLIBC support, thank you. Is there a list or 
something that shows the maximum file sizes for the recent kernels?

>As for filesystems, ext2, ext3, reiserfs, nfs, smbfs (though you have to
>enable a special option for it on mounting), xfs, jfs, just to name a few.
>
>
>
>  
>
>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>>owner@vger.kernel.org] On Behalf Of Iwan Sanders
>>Sent: Wednesday, December 29, 2004 5:45 PM
>>To: linux-kernel@vger.kernel.org
>>Subject: What kernel versions will allow files larger than 4 GB?]
>>
>>Hi people I'm trying to figure this out but can't seem to find any info.
>>
>>So could someone help me with this question: What kernel versions will
>>allow files larger than 4 GB? What filesystems?
>>
>>ps I am new to the linux kernel development is there a specification of
>>the various kernel versions?
>>
>>Greets,
>>
>>Iwan Sanders
>>
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>    
>>
>
>
>  
>



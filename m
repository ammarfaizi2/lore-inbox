Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268326AbRGZQ2P>; Thu, 26 Jul 2001 12:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268315AbRGZQ2F>; Thu, 26 Jul 2001 12:28:05 -0400
Received: from ns.guardiandigital.com ([209.11.107.5]:29971 "HELO
	juggernaut.guardiandigital.com") by vger.kernel.org with SMTP
	id <S268316AbRGZQ1x>; Thu, 26 Jul 2001 12:27:53 -0400
Message-ID: <3B60450A.9CCB0AA2@guardiandigital.com>
Date: Thu, 26 Jul 2001 12:27:54 -0400
From: Nick DeClario <nick@guardiandigital.com>
Reply-To: nick@guardiandigital.com
Organization: Guardian Digital, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Edouard Soriano <e_soriano@dapsys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Increase number of open files
In-Reply-To: <20010726.15213500@dap21.dapsys.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

/proc/sys/fs/file-max contains the max files.  The default is 4096.  Try
changing it to 8192, that should do the trick. 

	-Nick

Edouard Soriano wrote:
> 
> Hello,
> 
> Kernel used: 2.4.2-2 Redhat 7.0
> 
> >From time to time I have to close some Windows on my system to perform
> some other tasks, like printing a document.
> 
> There are no messages on the log files, but my understanding is
> a maximum number of concurrent files need to be modified.
> 
> Is there some parameters in /proc to set up without the need to
> reconfigure the kernel ?
> 
> Regards,
> 
> E. Soriano
> - 
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Nicholas DeClario
Systems Engineer                            Guardian Digital, Inc.
(201) 934-9230                Pioneering.  Open Source.  Security.
nick@guardiandigital.com            http://www.guardiandigital.com

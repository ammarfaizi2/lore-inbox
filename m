Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315155AbSEHUqf>; Wed, 8 May 2002 16:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315163AbSEHUqf>; Wed, 8 May 2002 16:46:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5648 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315155AbSEHUqe>;
	Wed, 8 May 2002 16:46:34 -0400
Message-ID: <3CD98E6D.F0F5BC4B@zip.com.au>
Date: Wed, 08 May 2002 13:45:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rscuss@omniti.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 3C509C Odd Behavior
In-Reply-To: <3CD98B36.8060203@omniti.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Scussel wrote:
> 
> I have read through the list seeing many emails on the 3c59x module,
> however, what I found for the recent posts was for laptops.
> 
> Here is the situation
> 
>     Tyan S2466 motherboard with 3Com (3c509c) onboard nic, Intel
> eepro100 pci nic.  RedHat 7.2 XFS. When the machine boots, the intel
> card comes up fine. The 3com card appears to initialize, can be seen
> from the box itself, however cannot ping out to anything else, and
> cannot be pinged from anywhere. If I down and up the card twice, it
> comes up fine with no more worries. No errors are generated.  The same
> behavior occurs with the default 2.4.9 kernel that comes with 7.2
> install, and with the 2.4.18 kernel.

Please enable debugging with the `debug=7' module parameter
and send me the logs from the whole session, including when
it doesn't work, and when it does.  There's more info on the
debug tools in Documentation/networking/vortex.txt.

Thanks.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbRATXX4>; Sat, 20 Jan 2001 18:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130138AbRATXXr>; Sat, 20 Jan 2001 18:23:47 -0500
Received: from embolism.psychosis.com ([216.242.103.100]:43780 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S129807AbRATXXg>; Sat, 20 Jan 2001 18:23:36 -0500
Message-ID: <3A6A1D75.54BFBE42@psychosis.com>
Date: Sat, 20 Jan 2001 18:21:25 -0500
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
Organization: www.psychosis.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1p8-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Douglas Gilbert <dgilbert@interlog.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: md= broken. Found problem. Can't fix it.  : (
In-Reply-To: <3A6A1512.C2684CCC@interlog.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
> 
> Dave,
> Look at the dmesg output and check that your
> "Kernel command line:" is what you think it
> is. Some older versions of lilo truncate it.
> Here is mine (which is what I expected):
> 
> Kernel command line: auto BOOT_IMAGE=lin240 ro root=803 scsihosts=imm:advansys:a
> dvansys:aha1542

No that is not the problem. I'm using GRUB (LILO == poopoo) and 
have looked at this throughly.

I can see from the dmesg via my debugging printk's output that str is properly
being passed. 

-- 
"Nobody will ever be safe until the last cop is dead."
		NH Rep. Tom Alciere - (My new Hero)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

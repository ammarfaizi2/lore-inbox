Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132115AbRAER7u>; Fri, 5 Jan 2001 12:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132701AbRAER7k>; Fri, 5 Jan 2001 12:59:40 -0500
Received: from [216.161.55.93] ([216.161.55.93]:23802 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S132115AbRAER72>;
	Fri, 5 Jan 2001 12:59:28 -0500
Date: Fri, 5 Jan 2001 10:00:40 -0800
From: Greg KH <greg@wirex.com>
To: Heitzso <xxh1@cdc.gov>
Cc: "'antirez@invece.org'" <antirez@invece.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Johannes Erdfelt'" <johannes@erdfelt.com>
Subject: Re: USB broken in 2.4.0
Message-ID: <20010105100040.A25217@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, Heitzso <xxh1@cdc.gov>,
	"'antirez@invece.org'" <antirez@invece.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	'Johannes Erdfelt' <johannes@erdfelt.com>
In-Reply-To: <B7F9A3E3FDDDD11185510000F8BDBBF2049E7F99@mcdc-atl-5.cdc.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <B7F9A3E3FDDDD11185510000F8BDBBF2049E7F99@mcdc-atl-5.cdc.gov>; from xxh1@cdc.gov on Fri, Jan 05, 2001 at 12:38:25PM -0500
X-Operating-System: Linux 2.4.0-prerelease (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 12:38:25PM -0500, Heitzso wrote:
> I just tested with fresh-out-of-the-box
> 2.4.0 and using the newer libusb 0.1.2 
> as suggested by antirez  (see email chain
> below for more info).  I compiled libusb
> and s10sh code this AM under 2.4.0. 
> 
> It blows up BAD by finding increasingly
> larger photo images in the camera over
> the usb link and extracting them to disk.
> So by the third file you're trying to
> extract gig sized files.  Obviously the
> filesystem files up, the sytem chokes, etc.
> 
> This is the same code that works fine
> under 2.2.18 kernel (I use it all of the
> time there).

I made the same request to Jordan Mendelson yesterday, who has the same
problem.  Could you be so kind as to try to narrow down which kernel
version this broke on?  I have reports that it used to work on -test9
but doesn't now.  Could you try -test10, etc and let me know?

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

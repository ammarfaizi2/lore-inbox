Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRABWvN>; Tue, 2 Jan 2001 17:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130612AbRABWvD>; Tue, 2 Jan 2001 17:51:03 -0500
Received: from quattro.sventech.com ([205.252.248.110]:25101 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S129436AbRABWur>; Tue, 2 Jan 2001 17:50:47 -0500
Date: Tue, 2 Jan 2001 17:20:21 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Heitzso <xxh1@cdc.gov>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: usb broken in 2.4.0 prerelease versus 2.2.18
Message-ID: <20010102172021.H8324@sventech.com>
In-Reply-To: <B7F9A3E3FDDDD11185510000F8BDBBF2049E7F7F@mcdc-atl-5.cdc.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <B7F9A3E3FDDDD11185510000F8BDBBF2049E7F7F@mcdc-atl-5.cdc.gov>; from Heitzso on Mon, Jan 01, 2001 at 05:31:34PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2001, Heitzso <xxh1@cdc.gov> wrote:
> Johannes, I apologize for not getting back to you earlier.
> Holidays, a changing kernel, and work, kept me away from
> the test.

No problem.

> DATA: s10sh 0.1.9 is a program used to access the USB
> bus to get to digital cameras and download pictures, etc.
> I used it for quite awhile with 2.4.0 test up until
> test 10(?) or so when it broke.  I then switched over to 
> 2.2.18 where s10sh works fine.  With the 2.4.0 
> prerelease out I compiled the 2.4.0 prerelease kernel 
> and tested and the 2.4.0 prerelease kernel still breaks 
> s10sh though the same s10sh program works fine with 2.2.18.
> 
> I cannot say that 2.4.0 is broken because I don't know
> if it is expected for a program like s10sh to break over
> the kernel shift.  What was odd for me was that is worked
> fine for quite awhile with 2.4.0 then snapped.

Technically, 2.4.0 is the newer code and the 2.2.18 code is a backport
of the 2.4.0 code. There isn't significant amounts of difference between
them, but the 2.2.18 code is slightly out of date.

> DEFINITION of SNAPPED: s10sh provides a command GETALL
> to download all of the pictures in a camera's 'directory'.
> Running GETALL under 2.4.0 now has the first picture file
> being somewhat reasonably sized, the second being roughly
> 200M in size, then the next being almost a gig in size,
> etc. until the parition I was in filled up and everything
> stops.  I then rebooted to 2.2.18 and the same program
> downloaded the pictures just fine.
> 
> If someone wants my .config files for 2.2.18 and 2.4.0
> let me know with instructions for getting it to you
> (i.e. attachments versus ...)  

Sounds like something got corrupted or expecting the wrong size bulk
transfers.

Could you give me your .config's? Attachment is fine (just don't send
them to the list).

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

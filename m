Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129172AbRA3HfR>; Tue, 30 Jan 2001 02:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129367AbRA3HfH>; Tue, 30 Jan 2001 02:35:07 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:30603 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S129172AbRA3HfD>;
	Tue, 30 Jan 2001 02:35:03 -0500
Message-ID: <20010130153448.B18976@saw.sw.com.sg>
Date: Tue, 30 Jan 2001 15:34:48 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Micah Gorrell <angelcode@myrealbox.com>
Cc: Romain Kang <romain@kzsu.stanford.edu>, linux-kernel@vger.kernel.org,
        root@chaos.analogic.com, "Craig I. Hagan" <hagan@cih.com>
Subject: Re: eepro100 - Linux vs. FreeBSD
In-Reply-To: <01ab01c08a1e$29d1c840$9b2f4189@angelw2k>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <01ab01c08a1e$29d1c840$9b2f4189@angelw2k>; from "Micah Gorrell" on Mon, Jan 29, 2001 at 11:06:11AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 11:06:11AM -0700, Micah Gorrell wrote:
> As stated in a number of previous messages to this list many people have had
> serious problems with the eepro100 driver in 2.4.  These problems where not
> there in 2.2 and it is not a select few machines showing this so I very much
> doubt that it is a configuration problem.  I assume that the intel driver
> would prolly fix all of these issues but its not ready for 2.4 yet and its
[snip]

In the first place, the "no resource" problem is a hardware one.
As far as I understand, it's a buggy (or undocumented) timing requirement
for some revisions.
This problem showed with any kernel, 2.2 or 2.4, until a workaround was
developed.  On a single computer suffering from that problem it showed not on
every boot, but about in 30 percents.  That's why the reports were different.
So, the kernel version is irrelevant to this problem.

Best regards
					Andrey V.
					Savochkin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

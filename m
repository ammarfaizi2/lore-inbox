Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbQLDTLc>; Mon, 4 Dec 2000 14:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129458AbQLDTLW>; Mon, 4 Dec 2000 14:11:22 -0500
Received: from [216.161.55.93] ([216.161.55.93]:23543 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129455AbQLDTLG>;
	Mon, 4 Dec 2000 14:11:06 -0500
Date: Mon, 4 Dec 2000 10:41:04 -0800
From: Greg KH <greg@wirex.com>
To: "J. Nick Koston" <lists@bdraco.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nightly usb oops
Message-ID: <20001204104104.C12998@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	"J. Nick Koston" <lists@bdraco.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20001204101309.A1368@bdraco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001204101309.A1368@bdraco.org>; from lists@bdraco.org on Mon, Dec 04, 2000 at 10:13:09AM -0500
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2000 at 10:13:09AM -0500, J. Nick Koston wrote:
> My machine crashes almost every night with this oops.  I've finally
> managed to catch it before it was totally gone.

This looks like a usb device was unplugged and plugged back in.
What devices do you have connected?
What host controller driver are you using?
What happens to the machine at this time of night (cron jobs, etc.)?
What is your .config?
What kernel is this (and if 2.4.0-test10, does this also happen on
2.4.0-test12-pre4)?
What kind of processor is this?

In short, lots more info needed.

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129311AbRAYRFk>; Thu, 25 Jan 2001 12:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132897AbRAYRFa>; Thu, 25 Jan 2001 12:05:30 -0500
Received: from zeus.kernel.org ([209.10.41.242]:62406 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129311AbRAYRFX>;
	Thu, 25 Jan 2001 12:05:23 -0500
Date: Thu, 25 Jan 2001 17:03:11 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mike Black <mblack@csihq.com>
Cc: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Largefile support in 2.4
Message-ID: <20010125170311.C12984@redhat.com>
In-Reply-To: <06dc01c0863d$29383390$e1de11cc@csihq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <06dc01c0863d$29383390$e1de11cc@csihq.com>; from mblack@csihq.com on Wed, Jan 24, 2001 at 02:38:00PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 24, 2001 at 02:38:00PM -0500, Mike Black wrote:
> How do normal users get to create/maintain large files (i.e. >2G) in Linux
> 2.4 on i386?

> The root user can make filesize unlimited but a non-root user cannot.  They
> come up with the same limits in both tcsh and bash (i.e. filesize
> 1048576 kbytes or 0x40000000)

Check your distribution's login process.  The kernel sets no default
limit, but several distributions let you set default limits for login.
It's quite common to see core limits set on all logins, and I seem to
recall at least Debian setting some of the other limits too.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

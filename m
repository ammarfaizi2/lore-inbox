Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132291AbRADWdQ>; Thu, 4 Jan 2001 17:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbRADWdG>; Thu, 4 Jan 2001 17:33:06 -0500
Received: from zeus.kernel.org ([209.10.41.242]:5649 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129183AbRADWcv>;
	Thu, 4 Jan 2001 17:32:51 -0500
Date: Thu, 4 Jan 2001 22:28:38 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Douglas Gilbert <dgilbert@interlog.com>
Cc: sct@redhat.com, "H. Peter Anvin" <hpa@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: devices.txt inconsistency]
Message-ID: <20010104222838.V1290@redhat.com>
In-Reply-To: <3A534CC1.B792AEFF@interlog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A534CC1.B792AEFF@interlog.com>; from dgilbert@interlog.com on Wed, Jan 03, 2001 at 11:01:05AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 03, 2001 at 11:01:05AM -0500, Douglas Gilbert wrote:
> Stephen,
> Did you respond to hpa on this matter?

Not yet, I'm just catching up on festive-season email.  Happy New
Year, all!

> [From the cc address it seems as though you 
> work both for transmeta as well as redhat.]

Nope, unless transmeta and red hat have been negotiating behind my
back. :)  The misdirected email is probably why I didn't spot this
earlier.

> > but something like this would be more accurate:
> > 162 char        Raw block device interface
> >                   0 = /dev/rawctl       Raw I/O control device
> >                   1 = /dev/raw/raw1     First raw I/O device
> >                   2 = /dev/raw/raw2     Second raw I/O device
> >                     ...
> > 
> > The raw(8) command supplied in RH 6.2 and 7.0 assumes the
> > latter structure. I have already alerted sct and this
> > change may be coming through in one of his patches.
> 
> The latter is actually better, so I certainly don't mind.  sct, should I
> change it?

Please do: the current util-linux should be using the new layout.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

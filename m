Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314389AbSDSFqt>; Fri, 19 Apr 2002 01:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314525AbSDSFqs>; Fri, 19 Apr 2002 01:46:48 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:51386 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314389AbSDSFqr>; Fri, 19 Apr 2002 01:46:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: George J Karabin <gkarabin@pobox.com>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB device support for 2.5.8(take 2)
Date: Fri, 19 Apr 2002 07:46:52 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        David Brownell <david-b@pacbell.net>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <074401c1e629$0a9ea020$6800000a@brownell.org> <20020417181722.GB1162@kroah.com> <1019194658.1734.12.camel@pane.chasm.dyndns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16yRDq-2G4UamC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 April 2002 07:37, George J Karabin wrote:
> Confusing as it may be to non-USB developers, how about using the USB
> spec terms "host" (for the PC) and "local host" (for the USB
> gadget/client/device/etc...)? I haven't seen those specific terms
> suggested yet after quickly searching through the archive.
>
> For shorthand, you might use "h" and "lh" suffixes, i.e., "usbh" for
> host code, and "usblh" for local host code. Or something else if that
> seems too terse.
>
> One well placed Readme file ought to make the distinction pretty clear
> to most end users, and USB developers shouldn't find it a problem at
> all.

Too short a difference. You easily skip it reading and there's a chance of typos.
Furthermore the first latter should differ for tab completion.
Target is actually quite good a name. It makes clear that there's only
one initiator of transactions on USB.

	Regards
		Oliver

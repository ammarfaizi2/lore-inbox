Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281172AbRKOX0V>; Thu, 15 Nov 2001 18:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281174AbRKOX0L>; Thu, 15 Nov 2001 18:26:11 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:52728 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S281172AbRKOX0C>; Thu, 15 Nov 2001 18:26:02 -0500
Date: Thu, 15 Nov 2001 23:25:41 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jussi Laako <jussi.laako@kolumbus.fi>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Cyrus <cyjamten@ihug.com.au>,
        linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: AMD761Agpgart+Radeon64DDR+kernel+2.4.14...no go...
Message-ID: <20011115232541.D14221@redhat.com>
In-Reply-To: <E161ybE-00016l-00@the-village.bc.nu> <3BEC44ED.B33682B5@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BEC44ED.B33682B5@kolumbus.fi>; from jussi.laako@kolumbus.fi on Fri, Nov 09, 2001 at 11:04:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 09, 2001 at 11:04:45PM +0200, Jussi Laako wrote:

> XFree86 4.1.0 doesn't work. Neither did rawhide 4.1.0 ~two months ago.
> Result was usually blank screen without signal and deadlock. Some versions
> did work when agpgart and DRI was disabled. Only CVS version worked with
> agpgart and DRI. Latest radeon DRI kernel module has been working for few
> months.
> 
> Haven't been testing RedHat's versions of XFree86 since switching to CVS
> version.

Works just fine for me: the Red Hat 7.2 rpms of XFree86-4.1 include
back-ports of the card init changes that went into the 4.1.99 cvs
tree.  Loss of vid signal and total system lockup were the symptoms I
was seeing too before that was all fixed.

Cheers,
 Stephen

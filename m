Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268396AbUHYFgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268396AbUHYFgY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 01:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268577AbUHYFgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 01:36:10 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:51870 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S268537AbUHYFfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 01:35:55 -0400
Date: Wed, 25 Aug 2004 07:35:16 +0200
To: Greg KH <greg@kroah.com>
Cc: "Nemosoft Unv." <nemosoft@smcc.demon.nl>,
       Linux USB Mailing List 
	<linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: kernel 2.6.8 pwc patches and counterpatches
Message-ID: <20040825053516.GA19771@gamma.logic.tuwien.ac.at>
References: <1092793392.17286.75.camel@localhost> <1092845135.8044.22.camel@localhost> <20040823221028.GB4694@kroah.com> <200408250058.24845@smcc.demon.nl> <20040824230458.GA12422@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040824230458.GA12422@kroah.com>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 24 Aug 2004, Greg KH wrote:
> > * you are going to accept that there is a driver in the Linux kernel that 
> > has a hook that _may_ be used to load a binary-only decompressor part into 
> > the kernel, at the user's disgression. Maybe, one day, that part will be 
> > open source too but I cannot guarantuee that. 
> 
> I now realize that.  So I've ripped that hook out, as it's only used to
> load a binary driver, which is not allowed.
> 
> That's the change I'm going to make.
> 
> If you want to send me a patch to tell me to rip the whole driver out,
> fine I will, no problems, I completly understand.

Bummer. This is rubbish. And I am sure that this is not the intention of
Linus comments. IF the module would be NON functional without the closed
plugin, then yes, rip it out. But it is useable, and this hook *can* be
used for closed modules, but also for other modules. 

It really looks like personal stuff going on here, not really objective
discussion on this point.

> But realize that anyone can then add it back, as the work you did was
> released under the GPL :)

And who will take over the level of support that Nemosoft has put into
this driver without the internal knowledge of the device? Good luck.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SCOPWICK (n.)
The flap of skin which is torn off you lip when trying to smoke an
untipped cigarette.
			--- Douglas Adams, The Meaning of Liff

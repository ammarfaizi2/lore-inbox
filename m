Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317421AbSG3Xhx>; Tue, 30 Jul 2002 19:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317423AbSG3Xhx>; Tue, 30 Jul 2002 19:37:53 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:51080 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S317421AbSG3Xhw>; Tue, 30 Jul 2002 19:37:52 -0400
Date: Tue, 30 Jul 2002 17:41:13 -0600
Message-Id: <200207302341.g6UNfDF11136@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Greg KH <greg@kroah.com>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
In-Reply-To: <Pine.LNX.4.44.0207310121470.8911-100000@serv>
References: <200207302312.g6UNC7Z10529@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.44.0207310121470.8911-100000@serv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel writes:
> Hi,
> 
> On Tue, 30 Jul 2002, Richard Gooch wrote:
> 
> > With your
> > "fixups", those drivers will break when "devfs=only" is passed in.
> 
> That feature is broken by design already anyway. devfs has
> absolutely no business managing that device pointer. You're
> duplicating code and it only makes it harder to properly protect
> it. As far as I can see it's still broken wrt to module unloading.

No, it's not. Look more closely.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbTIHX2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263717AbTIHX2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:28:49 -0400
Received: from gprs145-40.eurotel.cz ([160.218.145.40]:4999 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263688AbTIHX2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:28:48 -0400
Date: Tue, 9 Sep 2003 01:28:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: Sven =?iso-8859-1?Q?K=F6hler?= <skoehler@upb.de>
Cc: Paul Clements <Paul.Clements@SteelEye.com>, linux-kernel@vger.kernel.org
Subject: Re: [NBD] patch and documentation
Message-ID: <20030908232824.GH429@elf.ucw.cz>
References: <3F5CB554.5040507@upb.de> <20030908193838.GA435@elf.ucw.cz> <3F5CE0E5.A5A08A91@SteelEye.com> <3F5CE3E6.8070201@upb.de> <3F5CF045.DDDE475C@SteelEye.com> <3F5CFF0B.6080609@upb.de> <20030908222111.GG429@elf.ucw.cz> <3F5D0186.4030001@upb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5D0186.4030001@upb.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Another idea would be to be abled to specify the max_sectors while 
> >>connecting an NBD. That would add an optional paramter to the nbd-client 
> >>command line. (like it is possible for the blocksize)
> >
> >I do not see why it should be configurable...
> 
> We may regret to use a certain value, although i agree that 1MB should 
> be sufficient for the future.

I believe that 1MB is good, and good enough for close future. If that
ever proves to be problem, we can add handshake at that point. But I
do not believe it will be neccessary.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

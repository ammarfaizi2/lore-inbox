Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWBKQIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWBKQIO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 11:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWBKQIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 11:08:14 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:30479 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S932093AbWBKQIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 11:08:13 -0500
Date: Sat, 11 Feb 2006 17:08:13 +0100
From: iSteve <isteve@rulez.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Packet writing issue on 2.6.15.1
Message-ID: <20060211170813.3fb47a03@silver>
In-Reply-To: <m3bqxd999u.fsf@telia.com>
References: <20060211103520.455746f6@silver>
	<m3r76a875w.fsf@telia.com>
	<20060211124818.063074cc@silver>
	<m3bqxd999u.fsf@telia.com>
X-Mailer: Sylpheed-Claws 2.0.0cvs42 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Feb 2006 16:59:09 +0100
Peter Osterlund <petero2@telia.com> wrote:
> > If the driver cannot handle variable packet size, and it is not matter of
> > filesystem but matter of CDRW (which I presume), shouldn't the whole
> > pktsetup fail?
> 
> pktsetup can be run before there is a disc in the drive. Therefore,
> these kinds of checks are done when you attempt to open the device for
> writing.
> 

Any plans or time estimation to support variable packet size?

BTW, can I currently work with packet writing if I only have a CDR? I know it
technically is possible, I've seen it done (not on Linux though), but I wonder
if it is possible with current codebase.
-- 
 -- iSteve

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266036AbUAFAjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266021AbUAFAhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:37:11 -0500
Received: from findaloan.ca ([66.11.177.6]:20690 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S266027AbUAFAgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:36:35 -0500
Date: Mon, 5 Jan 2004 17:25:59 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Shawn <core@enodev.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
       Daniel Jacobowitz <dan@debian.org>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040105222559.GA3513@mark.mielke.cc>
Mail-Followup-To: Shawn <core@enodev.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andries Brouwer <aebr@win.tue.nl>,
	Daniel Jacobowitz <dan@debian.org>, Rob Love <rml@ximian.com>,
	rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>
References: <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl> <Pine.LNX.4.58.0401050749490.21265@home.osdl.org> <20040105205228.A1092@pclin040.win.tue.nl> <Pine.LNX.4.58.0401051224480.2153@home.osdl.org> <1073341077.21797.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073341077.21797.17.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 04:17:57PM -0600, Shawn wrote:
> Having said that, I will say that they are /somewhat/ stable. You can,
> in general, say 'fdisk /dev/hdb' and be editing the same block device's
> partition table... That is, if nothing has changed in the BIOS or
> hardware or kernel or....
> ...
> As an admin, would I at least theoretically have /some/ consistency if
> merely for my own sanity when dealing with block devices by hand (I do
> need to setup LVM stuff from time to time)??

If all you care about is that /dev names remain consistent, you need
not fear. udev and devfs are two different ways of providing this
consistency. They abstract the device numbers from the /dev names,
meaning that you don't have to care if the numbers change. The names
don't.

Cheers,
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/


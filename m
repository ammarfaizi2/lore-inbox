Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbUAEX0U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266008AbUAEXZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:25:46 -0500
Received: from CPE-24-163-213-29.mn.rr.com ([24.163.213.29]:16052 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S266009AbUAEXXi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:23:38 -0500
Subject: Re: udev and devfs - The final word
From: Shawn <core@enodev.com>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Linus Torvalds <torvalds@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
       Daniel Jacobowitz <dan@debian.org>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <1073343916.21797.21.camel@www.enodev.com>
References: <Pine.LNX.4.58.0401041302080.2162@home.osdl.org>
	 <20040104230104.A11439@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401041847370.2162@home.osdl.org>
	 <20040105030737.GA29964@nevyn.them.org>
	 <Pine.LNX.4.58.0401041918260.2162@home.osdl.org>
	 <20040105132756.A975@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401050749490.21265@home.osdl.org>
	 <20040105205228.A1092@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401051224480.2153@home.osdl.org>
	 <1073341077.21797.17.camel@localhost>
	 <20040105222559.GA3513@mark.mielke.cc>
	 <1073343916.21797.21.camel@www.enodev.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1073345016.21797.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 17:23:36 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And looking back on some of these emails, it seems there was more than
just me being confused. Seems this is a point worth emphasizing.

On Mon, 2004-01-05 at 17:05, Shawn wrote:
> On Mon, 2004-01-05 at 16:25, Mark Mielke wrote:
> > On Mon, Jan 05, 2004 at 04:17:57PM -0600, Shawn wrote:
> > > ...
> > > As an admin, would I at least theoretically have /some/ consistency if
> > > merely for my own sanity when dealing with block devices by hand (I do
> > > need to setup LVM stuff from time to time)??
> > 
> > If all you care about is that /dev names remain consistent, you need
> > not fear. udev and devfs are two different ways of providing this
> > consistency. They abstract the device numbers from the /dev names,
> > meaning that you don't have to care if the numbers change. The names
> > don't.
> I'm obviously confused if this is true, as then I do not know how the
> great and powerful udev derives the names if not from the numbers, or
> some other sysfs info.
> 
> Anyway, assuming this is true, I have much less concern.


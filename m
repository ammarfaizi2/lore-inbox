Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263395AbVFYPBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263395AbVFYPBi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 11:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbVFYPBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 11:01:38 -0400
Received: from styx.suse.cz ([82.119.242.94]:58281 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S263395AbVFYPAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 11:00:34 -0400
Date: Sat, 25 Jun 2005 17:00:30 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Paul Sladen <thinkpad@paul.sladen.org>, linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, abonilla@linuxwireless.org,
       borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
Message-ID: <20050625150030.GA1636@ucw.cz>
References: <1119559367.20628.5.camel@mindpipe> <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net> <20050625144736.GB7496@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050625144736.GB7496@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2005 at 04:47:36PM +0200, Pavel Machek wrote:
> Hi!
> 
> 
> > > Yup, it's just doing port IO.  Get a kernel debugger for windows like
> > > softice and this will be trivial to RE.
> > > READ_PORT_USHORT / WRITE_PORT_UCHAR / READ_PORT_UCHAR
> > 
> > There are 3 ports involved.  The 0xed "non-existant delay port" and a pair
> > of ports that are through the Super-I/O / IDE.  They are used in a
> > index+value setup similar to reading/writing the AT keyboard
> > > controller.
> 
> I think you got it... 2ports seem like enough for some kind of small
> u-controller...
 
Quite possibly the ACPI EC. Most likely a side entrance into the onboard 8042.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

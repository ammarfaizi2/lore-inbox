Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263125AbVCKE5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbVCKE5C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbVCKE5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:57:02 -0500
Received: from gate.crashing.org ([63.228.1.57]:40153 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263125AbVCKE4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:56:52 -0500
Subject: Re: Average power consumption in S3?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Moritz Muehlenhoff <jmm@inutil.org>,
       Martin Josefsson <gandalf@wlug.westbo.se>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050311034615.GA314@thunk.org>
References: <20050309142612.GA6049@informatik.uni-bremen.de>
	 <1110388970.1076.48.camel@tux.rsn.bth.se>
	 <20050310180826.GA6795@informatik.uni-bremen.de>
	 <20050311034615.GA314@thunk.org>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 15:51:19 +1100
Message-Id: <1110516679.32557.350.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 22:46 -0500, Theodore Ts'o wrote:
> On Thu, Mar 10, 2005 at 07:08:26PM +0100, Moritz Muehlenhoff wrote:
> > I've got the e100 and with WOL disabled and Matthew's hacked radeontool
> > power consumption decreases to 970 mWh.
> 
> I have a T40p, and with the following patches (versus 2.6.11) and the
> following sleep script, I have power consuption down to 580 mWh.
> 
> The 05-radeonfb-Thinkpad-Power.patch will have to patched with your
> specific Thinkpad model number, or booted with the force_sleep option.
> See the Linux thinkpad mailing list (linux-thinkpad@linux-thinkpad.org) 
> archives for more information.
> 
> Warning: The 05-radeonfb-Thinkpad-Power.patch is not quite ready for
> merging, but compared to completely pathetic battery life when using
> ACPI's suspend-to-memory without them, it's definitely worth it.

Hi Ted !

Hopefully, somebody is gathering those patches. I intend to merge them
all at one point, though I can't promise it will happen before 2.6.12.

It would be good to "ping" me regulary though ;)

I've sort-of been waiting for ATI to tell me how to retreive the proper
memory register setting from the BIOS, since the code in there currently
is quite powerbook specific, and might not write the exact correct value
on all models. I suppose it works fine on yours so far, but I'd rather
have a way to know the right value ... unfortunately, they didn't reply
on this request.

Ben.



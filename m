Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTEaP2U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 11:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTEaP2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 11:28:20 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:42193 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S264531AbTEaP2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 11:28:19 -0400
Date: Sun, 1 Jun 2003 01:41:42 +1000
From: CaT <cat@zip.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70: pcmcia oops (a real one! honest!)
Message-ID: <20030531154142.GA473@zip.com.au>
References: <20030528042610.GD6501@zip.com.au> <20030529090209.B12513@flint.arm.linux.org.uk> <20030529212139.GA25971@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529212139.GA25971@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 02:21:39PM -0700, Greg KH wrote:
> On Thu, May 29, 2003 at 09:02:09AM +0100, Russell King wrote:
> > On Wed, May 28, 2003 at 02:26:10PM +1000, CaT wrote:
> > > removed my xircom pcmcia realport card and put in another. End result was
> > > total loss of ps2 keyboard functionality (everything else, inc the ps2 mouse
> > > still works). I then removed the xircom card. The following was in dmesg:
> > 
> > I'm assuming that this is something Gregkh needs to look into and not
> > myself; my guess is that it's related to the pci device accounting stuff.
> > 
> > Greg?
> 
> Yeah, it could be.  Cat, can you revert the following patch from your
> tree and let me know if it fixes your problem or not?

The kernel no longer crashes on remove and I can reinsert and it
recognises the card without hassle. I do get no messages on eject though
(about devices being deregistered, etc) but I get msgs on insert (about
them getting regstered etc). One time I didn't get the card recognised
at all on insert... dunno if that was myfault or not but on eject and
reinsert all was fine.

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm

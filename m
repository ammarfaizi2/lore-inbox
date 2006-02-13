Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWBMWMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWBMWMO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWBMWMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:12:14 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:17607 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1030205AbWBMWMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:12:13 -0500
Date: Mon, 13 Feb 2006 17:12:11 -0500
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de, alex@samad.com.au
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060213221211.GB29940@csclub.uwaterloo.ca>
References: <43EB0DEB.nail52A1LVGUO@burner> <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr> <43EB7210.nailIDH2JUBZE@burner> <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner> <20060210114930.GC2750@DervishD> <20060213005002.GK26235@samad.com.au> <43F098A2.nailKUSL1W9PE@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F098A2.nailKUSL1W9PE@burner>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 03:33:06PM +0100, Joerg Schilling wrote:
> This is a deficite of the Linux kernel model. You don't have similar
> problems on Solaris.

Here is something I have wondered about:

If solaris assigns consistent device entries to a device that is
hotplugged each time it is connected, which is certainly something that
can be implemented, then how many such devices can it handle before it
runs out of room for new devices?

After all I could theoretically have 100000 usb and firewire cd-rw
drives.  What if I was to plug each one in one at a time in turn.  Would
it deal with that?  What kind of references would I end up with for them
by the time I hit number 99999?  Do I end up with device 99999,0,0 in
cdrecord/libscg?

At some point you have to give up on old devices or you could end up
having to keep an index the whole universe.

Len Sorensen

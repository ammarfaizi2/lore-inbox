Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030542AbWBNJyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030542AbWBNJyV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030543AbWBNJyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:54:21 -0500
Received: from smtp.enter.net ([216.193.128.24]:1286 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1030542AbWBNJyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:54:20 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Martin Mares <mj@ucw.cz>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Tue, 14 Feb 2006 05:03:26 -0500
User-Agent: KMail/1.8.1
Cc: Marcin Dalecki <dalecki.marcin@neostrada.pl>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       jerome.lacoste@gmail.com, peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
References: <20060208162828.GA17534@voodoo> <2D9D57EA-1197-4965-82ED-61DEAF73D9F9@neostrada.pl> <mj+md-20060214.091056.25971.atrey@ucw.cz>
In-Reply-To: <mj+md-20060214.091056.25971.atrey@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602140503.27668.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 04:20, Martin Mares wrote:
<snip>
> I think that it's clear from all this, that device naming is a matter
> of policy and that the best the OS can do is to give the users a way
> how to specify their policy, which is what udev does.
>
> 				Have a nice fortnight

True, and the point I was trying to make. Joerg has a policy that works well 
on some systems and doesn't on others. Rather than giving people a clear 
option to use the other system he has. In Linux udev provides a user 
configurable policy that works extremely well. Rather than change the 
software to accomodate udev/hald as he accomodates vold on Solaris Joerg 
insists on having *nearly* pointless warnings and insisting that his method 
is the only valid one.

That's the reason I asked him if he'd accept a patch that removed said warning 
and converted the device the user passed in (be it /dev/sr0 or /dev/cdrw) and 
internally converts it into his naming scheme. I have yet to see a response 
to this.

DRH

PS: Joerg my offer for that still stands, as does my offer to _attempt_ to fix 
the bugs you've reported in the ATAPI layer. Sadly I cannot offer to repair 
ide-scsi, as that is deprecated and scheduled for removal. However, with that 
being the case my offer to attempt to repair the noted problems with the 
mangling of commands by the ATAPI system remains. All I ask for is a detailed 
report including which model drives have the problem and debugging output so 
that I can attempt to repair the problem since I do not have the access to 
hardware that you do.

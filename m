Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268722AbUIXNJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268722AbUIXNJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 09:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268720AbUIXNJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 09:09:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16616 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268734AbUIXNJh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 09:09:37 -0400
Date: Fri, 24 Sep 2004 14:09:35 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [Pcihpd-discuss] Re: Is there a user space pci rescan method?
Message-ID: <20040924130935.GB16153@parcelfarce.linux.theplanet.co.uk>
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <200409241241.19654@bilbo.math.uni-mannheim.de> <4154083B.6040109@ppp0.net> <200409241412.45204@bilbo.math.uni-mannheim.de> <41541009.9080206@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41541009.9080206@ppp0.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 02:16:09PM +0200, Jan Dittmer wrote:
> My point was, I load dummyphp with showunused=0 and only get dirs for the
> slots with devices in them. Now I decide to put a network card (or whatever
> I have to spare) in an empty slot, hope that the system doesn't reboot
> immediately, and voila I don't have any /sys/bus/pci/slots dir to enable
> the slot and have to reboot nevertheless. Or does the pci system a rescan
> if I reinsert the module?

That is DANGEROUS and WILL DESTROY YOUR SYSTEM.  Under no circumstances
should we be encouraging people to do that.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain

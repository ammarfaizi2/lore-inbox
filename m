Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966468AbWKYMeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966468AbWKYMeA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 07:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966484AbWKYMeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 07:34:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65035 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S966468AbWKYMeA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 07:34:00 -0500
Date: Fri, 24 Nov 2006 23:40:15 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       seife@suse.de
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Message-ID: <20061124234015.GB4782@ucw.cz>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org> <20061122152328.GI5200@stusta.de> <20061122154230.74889e3d@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122154230.74889e3d@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This might not have been the original purpose of suspend, but it works 
> > quite well, STR is obviously not an alternative, and it doesn't matter 
> > much whether it takes a minute.
> 
> Suspend to ram at the moment is for the very very brave. Having added
> resume quirks to the PCI resume code I've got basic resume behaving on at
> two boxes where resume ate the disks. I've now found a third case in
> testing where str/resume resumes when using Jmicron 365/366 your IDE disks
> swapped over which makes a really nasty mess, and that controllers like
> the SIL680 come back from resume misclocked and so on.

Hmm... how common are these machines? We are using unpatched kernel
for suse10.2... OTOH we only support machines from the whitelist, all
notebooks...
							Pavel

-- 
Thanks for all the (sleeping) penguins.

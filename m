Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbTFEWdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 18:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbTFEWdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 18:33:36 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:54476 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S265228AbTFEWdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 18:33:35 -0400
Date: Fri, 6 Jun 2003 00:45:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Greg KH <greg@kroah.com>, Hanna Linder <hannal@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFT/C 2.5.70] Input class hook up to driver model/sysfs
Message-ID: <20030605224535.GH608@elf.ucw.cz>
References: <20030605220716.GF608@elf.ucw.cz> <Pine.LNX.4.44.0306051511350.13077-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306051511350.13077-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, that means that another patch is needed to create hierarchy for
> > power managment... This sysfs stuff is getting hairy.
> 
> No it's not. The hierarchy is the device tree, which is the original 
> purpose of it, remember? 

device tree is okay with me, but... it took quite a long patch to add
it to classes. I thought that classes are only going to be symlinks
into device tree, but this patch added classes without adding to the
device tree...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVCNDua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVCNDua (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 22:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVCNDua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 22:50:30 -0500
Received: from stark.xeocode.com ([216.58.44.227]:45701 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261927AbVCNDuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 22:50:14 -0500
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Greg Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org,
       Patrick McFarland <pmcfarland@downeast.net>
Subject: Re: OSS Audio borked between 2.6.6 and 2.6.10
References: <87u0ng90mo.fsf@stark.xeocode.com>
	<200503130152.52342.pmcfarland@downeast.net>
	<874qff89ob.fsf@stark.xeocode.com>
	<200503140103.55354.s0348365@sms.ed.ac.uk>
In-Reply-To: <200503140103.55354.s0348365@sms.ed.ac.uk>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 13 Mar 2005 22:50:00 -0500
Message-ID: <87sm2y7uon.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan <s0348365@sms.ed.ac.uk> writes:

> The intel8x0 driver is probably one of the most widely used ALSA drivers, so 
> I'd hope it wasn't broken! 

I would have hoped so too at the time. Reporting it to the list didn't get any
response since it was already fixed upstream, but it took a while before it
was merged down to the linux tree.

Also, it seems chipsets can be wired up differently in different motherboards.
A driver can work perfectly for hundreds of boards and still fail on the same
chipset on another machine.

In any case "X code is broken" "why not use Y code instead" isn't really
productive. It's a good thing I was using the OSS drivers; if everyone used
the alsa drivers and nobody was testing the OSS drivers nobody would know they
were broken.

-- 
greg


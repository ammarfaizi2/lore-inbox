Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272606AbTHEJRN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 05:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272599AbTHEJRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 05:17:07 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:6043 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272609AbTHEJPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 05:15:04 -0400
Date: Tue, 5 Aug 2003 11:14:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Fix up refrigerator to work with ^Z-ed processes
Message-ID: <20030805091421.GC388@elf.ucw.cz>
References: <20030726225115.GA501@elf.ucw.cz> <Pine.LNX.4.44.0308041756080.23977-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308041756080.23977-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This makes refrigerator work with ^Z-ed processes (and not eat
> > disks). Thanks to (have to find out who, I should sleep and not be
> > splitting patches). [Hand edited, apply by hand; or there should be
> > script for recomputing @@ X,Y Z,T @@'s somewhere].
> > 
> > schedule() added makes processes start at exactly that point, making
> > printouts nicer.
> 
> This didn't apply, so in making the changes by hand, I took the liberty to 
> rename interesting_process() to freezeable() to make it a bit easier to 
> read. Revised patch below. 

Yes, that's better name, patch looks good. Thanks,
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

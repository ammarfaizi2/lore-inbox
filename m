Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbUDOL1I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 07:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUDOL1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 07:27:08 -0400
Received: from gprs214-18.eurotel.cz ([160.218.214.18]:22401 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262413AbUDOL1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 07:27:05 -0400
Date: Thu, 15 Apr 2004 13:26:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       lkml@martin.mh57.de
Subject: Re: 2.6.5-mm2 (swsusp not working and acpi problem) (fwd)
Message-ID: <20040415112652.GB28414@elf.ucw.cz>
References: <20040410134754.GD468@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040410134754.GD468@openzaurus.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I tried updating from 2.6.4-rc1-mm2 to 2.6.5-mm2, and I found two
> problems:
> 
> First, swsusp stopped working, I get a NULL pointer in
> _poke_blanked_console' after all the other things seem to be fine.

Its not in poke blanked console, its is in memorymanagment. Try latest -aa.

> I made a screenshot available under
> http://mh57.de/~martin/oops-part1.png and
> http://mh57.de/~martin/oops-part2.png

Hmm, someone should create "OCR for linux-kernel-mailinglist" project.

> This happens regardless of starting X or using the framebuffer. The
> hardware is an IBM Thinkpad T41p. In the screenshots above, the kernel
> is tainted from the madwifi module, but not loading it before did not
> change the oops.
> 
> The kernel contains two more patches, linux-iscsi-kernel-4.0.1.3.patch
> and linux-2.6.3-mppe-mppc-0.99.patch.gz, but these two modules were not
> loaded before during my tests.

Really? Those taints look scary.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

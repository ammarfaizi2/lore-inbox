Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263643AbTFHSFk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 14:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTFHSFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 14:05:40 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:17293 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263643AbTFHSFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 14:05:36 -0400
Date: Sun, 8 Jun 2003 20:18:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       andrew.grover@intel.com, trivial@rustcorp.com.au
Subject: Re: [2.5 patch] remove unused reset_videobios_after_s3
Message-ID: <20030608181819.GB9182@elf.ucw.cz>
References: <20030608104737.GA16164@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030608104737.GA16164@fs.tum.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> reset_videobios_after_s3 is used nowhere inside 2.5.70-mm6. Unless there 
> are plans to use it in the near future I suggest the patch below to 
> remove it.
> 
> I've tested the compilation with 2.5.70-mm6.

Please keep it. I know there are machines that need it (I have one at
home, but that does not seem to have valid DMI tables), but I do not
yet have their DMI strings.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

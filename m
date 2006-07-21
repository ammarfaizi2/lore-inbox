Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWGUPMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWGUPMu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 11:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWGUPMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 11:12:50 -0400
Received: from thunk.org ([69.25.196.29]:21395 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750757AbWGUPMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 11:12:49 -0400
Date: Fri, 21 Jul 2006 11:12:39 -0400
From: Theodore Tso <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: Auke Kok <auke-jan.h.kok@intel.com>, pavel@ucw.cz, cramerj@intel.com,
       john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: e1000: "fix" it on thinkpad x60 / eeprom checksum read fails
Message-ID: <20060721151239.GC2290@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, Auke Kok <auke-jan.h.kok@intel.com>,
	pavel@ucw.cz, cramerj@intel.com, john.ronciak@intel.com,
	jesse.brandeburg@intel.com, jeffrey.t.kirsher@intel.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060721005832.GA1889@elf.ucw.cz> <44BFADA6.6090909@intel.com> <20060720170758.GA9938@atrey.karlin.mff.cuni.cz> <44BFBE9F.7070600@intel.com> <20060721064105.aa960acd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060721064105.aa960acd.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2006 at 06:41:05AM -0700, Andrew Morton wrote:
> > It's completely not acceptable to run when the EEPROM checksum fails - you 
> > might even be running with the wrong MAC address, or worse. Lets fix this the 
> > right way instead.
> 
> A printk which helps the user to understand all this saga would be very nice.
> -

And if someone who understands all of these details could put a note
in the thinkwiki (say, here:
http://www.thinkwiki.org/wiki/Ethernet_Controllers#Intel_Gigabit_.2810.2F100.2F1000.29)
it would be greatly appreciated.

						- Ted

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751608AbWCTIPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbWCTIPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWCTIPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:15:30 -0500
Received: from mail.suse.de ([195.135.220.2]:50086 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750742AbWCTIP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:15:29 -0500
Date: Mon, 20 Mar 2006 09:13:13 +0100
From: Stefan Seyfried <seife@suse.de>
To: Tom Marshall <tommy@home.tig-grr.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend2-announce] Nigel's work and the future of Suspend2.
Message-ID: <20060320081312.GA26527@suse.de>
References: <200603071005.56453.nigel@suspend2.net> <20060308122500.GB3274@elf.ucw.cz> <1141839915.5382.49.camel@marvin.se.eecs.uni-kassel.de> <200603082139.06259.rjw@sisk.pl> <20060318060846.GA11546@home.tig-grr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060318060846.GA11546@home.tig-grr.com>
X-Operating-System: Novell Linux Desktop 10 (i586), Kernel 2.6.16-rc5-git9-2-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 10:08:46PM -0800, Tom Marshall wrote:
 
> I have the opposite problem, more or less (S3 not swsusp):
> 
> I have two identical (except for different model drives) Thinkpad T42
> laptops that exhibit the same behavior.  S3 mostly works but occasionally
> fails to resume, for values of occasionally that vary between 1-2 successful
> resumes before failure to several dozens.
 
> If anyone is willing to work with me on tracking down the issue in a vendor
> kernel (Ubuntu Dapper), I would be more than happy to apply debug patches
> and supply any debug info requested.

AFAIK Ubuntu always uses "vbetool post" and "vbetool vbestate save/restore"
on most Thinkpads.

I'd say - get rid of this and instead put "acpi_sleep=s3_bios,s3_mode" on
the kernel command line. The whole vbetool magic is a bit suspicious to me.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen

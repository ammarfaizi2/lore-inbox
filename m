Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWG3L2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWG3L2e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 07:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWG3L2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 07:28:33 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:34976 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932266AbWG3L2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 07:28:33 -0400
Date: Sun, 30 Jul 2006 12:28:27 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw3945 status
Message-ID: <20060730112827.GA25540@srcf.ucam.org>
References: <20060730104042.GE1920@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730104042.GE1920@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 12:40:42PM +0200, Pavel Machek wrote:

> I'm unfortunate enough to have x60 with ipw card. Card works okay, but
> driver is 16K LoC and needs binary daemon (ugh). Plus, it lives as an
> external module...

I have a mostly working replacement for the binary daemon, but it causes 
the firmware to crash at the point where it triggers an association. If 
anyone's keen on trying to figure out what's up, I'll clean up the code 
and stick it somewhere.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

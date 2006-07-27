Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWG0Oo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWG0Oo6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWG0Oo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:44:58 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:53901 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751084AbWG0Oo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:44:57 -0400
Date: Thu, 27 Jul 2006 15:44:52 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Pavel Machek <pavel@suse.cz>, vojtech@suse.cz,
       Len Brown <len.brown@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org
Subject: Re: Generic battery interface
Message-ID: <20060727144452.GB11707@srcf.ucam.org>
References: <20060727002035.GA2896@elf.ucw.cz> <20060727140539.GA10835@srcf.ucam.org> <41840b750607270739u7b6fe7efl5ac5ec147d83e624@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607270739u7b6fe7efl5ac5ec147d83e624@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 05:39:06PM +0300, Shem Multinymous wrote:

> Can we really assume there's one driver providing all battery-related
> attributes?

Hmm. That's a good point.

> So, if we insist on a standard battery device class name, how do we
> cope with multiple sources of information and control functions?

Ignoring the multiple sources of information bit for the moment, we need 
to figure out the correct method of event notification anyway. There's a 
long-term plan to get rid of /proc/acpi, so acpi notifications need to 
be more more generic in any case.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbULPVKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbULPVKk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 16:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbULPVKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 16:10:40 -0500
Received: from dsl027-176-166.sfo1.dsl.speakeasy.net ([216.27.176.166]:8136
	"EHLO waste.org") by vger.kernel.org with ESMTP id S262024AbULPVK0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 16:10:26 -0500
Date: Thu, 16 Dec 2004 13:10:24 -0800
From: Matt Mackall <mpm@selenic.com>
To: Mark Broadbent <markb@wetlettuce.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
Message-ID: <20041216211024.GK2767@waste.org>
References: <59719.192.102.214.6.1103214002.squirrel@webmail.wetlettuce.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59719.192.102.214.6.1103214002.squirrel@webmail.wetlettuce.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 04:20:02PM -0000, Mark Broadbent wrote:
> Hi,
> 
> I'm having problem using ethereal/tcpdump in conjunction with the
> netconsole (built as a module).  If the netconsole is loaded and I try to
> launch tcpdump on the same interface as the netconsole is transmitting I
> get a hard lock-up.  The following commands can consistently do this:
> # tcpdump -i eth0
> eth0: Promiscuous Mode Entered
> <... normal output ...>
> ^C
> # modprobe netconsole
> # tcpdump -i eth0
> eth0: Promiscuous Mode Entered
> <4>NMI Watchdog detected LOCKUP

Joy. Can you try it on your other interface to see if it's
driver-specific?

-- 
Mathematics is the supreme nostalgia of our time.

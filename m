Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUCZWSr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 17:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUCZWSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 17:18:47 -0500
Received: from dhcp18-183.bio.purdue.edu ([128.210.18.183]:7296 "EHLO
	lapdog.ravenhome.net") by vger.kernel.org with ESMTP
	id S261358AbUCZWSq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 17:18:46 -0500
From: Praedor Atrebates <praedor@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: System clock speed too high - 2.6.3 kernel
Date: Fri, 26 Mar 2004 17:18:37 -0500
User-Agent: KMail/1.6.1
References: <200403261430.18629.praedor@yahoo.com> <200403261800.32717.praedor@yahoo.com> <1080338266.5408.316.camel@cog.beaverton.ibm.com>
In-Reply-To: <1080338266.5408.316.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200403261718.42766.praedor@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 March 2004 04:57 pm, john stultz held forth thus:
[...]
> I noticed in the dmesg you sent me that you're using the ACPI PM time
> source. There has just recently been a bug opened for a very similar
> issue (see http://bugme.osdl.org/show_bug.cgi?id=2375 ).
>
> First of all, scratch trying "clock=pit" and test booting w/
> "clock=tsc". If that resolves the issue, disable ACPI PM timesource
> support (under the ACPI menu) in your kerel and that should fix you for
> the short term.
[...]

OK.  Re-enabling ACPI in the append statement and using "clock=tsc" works.  
The clock is as it should be.

I took a good look at the bios menus and there just isn't really anything 
there I can fiddle with:

ACPI OS Fast Post.........................[enable/disable]
Silent boot.....................................[enable/disable]
PnP OS..........................................[enable/disable]

That's it.  

Thanks for the help.

praedor

-- 
"George W. Bush is a deserter, an election thief, a drunk driver, a WMD 
liar and a functional illiterate. And he poops his pants." 
--Barbara Bush, his mother

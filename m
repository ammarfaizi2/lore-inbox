Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUC3DYC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 22:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUC3DYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 22:24:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:32945 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261807AbUC3DX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 22:23:59 -0500
Date: Mon, 29 Mar 2004 19:17:50 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Chris Cheney <ccheney@cheney.cx>
Cc: len.brown@intel.com, tony@atomide.com, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net, patches@x86-64.org, ak@suse.de,
       pavel@ucw.cz
Subject: Re: [PATCH] x86_64 VIA chipset IOAPIC fix
Message-Id: <20040329191750.4bec9da3.rddunlap@osdl.org>
In-Reply-To: <20040326043447.GD9248@cheney.cx>
References: <20040325033434.GB8139@atomide.com>
	<20040326030458.GZ9248@cheney.cx>
	<20040326033536.GA8057@atomide.com>
	<1080274911.748.130.camel@dhcppc4>
	<20040326043447.GD9248@cheney.cx>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004 22:34:47 -0600 Chris Cheney <ccheney@cheney.cx> wrote:

| On Thu, Mar 25, 2004 at 11:21:51PM -0500, Len Brown wrote:
| > On Thu, 2004-03-25 at 22:35, Tony Lindgren wrote:
| > > * Chris Cheney <ccheney@cheney.cx> [040325 19:06]:
| > > > On Wed, Mar 24, 2004 at 07:34:34PM -0800, Tony Lindgren wrote:
| > > > 
| > > > BTW - Does this also solve the problem with needing USB to be compiled
| > > > directly into the kernel in 64bit mode?
| > > 
| > > OK, tried it and it does not help there. Also loding ACPI processor and
| > > thermal zone compiled in hangs the machine, but loading them as modules
| > > work.
| > 
| > where does it hang when processor and thermal are compiled-in?
| 
| You had mentioned before there is a way to decompile SSDT with 3rd party
| (non iasl.exe) asl tools, do you happen to know where to get them? Also
| does the usual dsdt override patch (acpi.sf.net) allow you to override
| the ssdt or does it only work for the dsdt?

There are some non-Intel ACPI (dumping) tools in CVS (acpidump and
pmtools/acpi*) at this SF.net project:
  https://sourceforge.net/projects/acpi/
I expect that I need to make those available as tarballs.

And Len has pmtools (and dmidecode) available here:
  http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

However, I'm not aware of any of these decompiling the SSDT...

--
~Randy

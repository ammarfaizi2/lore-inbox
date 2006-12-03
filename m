Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758881AbWLCXYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758881AbWLCXYM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 18:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758904AbWLCXYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 18:24:12 -0500
Received: from pythia.bakeyournoodle.com ([203.82.209.197]:11406 "EHLO
	pythia.bakeyournoodle.com") by vger.kernel.org with ESMTP
	id S1758881AbWLCXYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 18:24:11 -0500
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Mon, 4 Dec 2006 10:23:45 +1100
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: Device naming randomness (udev?)
Message-ID: <20061203232345.GK27551@bakeyournoodle.com>
Mail-Followup-To: "Martin J. Bligh" <mbligh@mbligh.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@suse.de>
References: <45735230.7030504@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45735230.7030504@mbligh.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2006 at 02:39:44PM -0800, Martin J. Bligh wrote:
> This PC has 1 ethernet interface, an e1000. Ubuntu Dapper.
> 
> On 2.6.14, my e1000 interface appears as eth0.
> On 2.6.15 to 2.6.18, my e1000 interface appears as eth1.
> 
> In both cases, there are no other ethX interfaces listed in
> "ifconfig -a". There are no modules involved, just a static
> kernel build.
> 
> Is this a bug in udev, or the kernel? I'm presuming udev,
> but seems odd it changes over a kernel release boundary.
> Any ideas on how I get rid of it? Makes automatic switching
> between kernel versions a royal pain in the ass.

Have a look at /etc/iftab.

Yours Tony

   linux.conf.au       http://linux.conf.au/ || http://lca2007.linux.org.au/
   Jan 15-20 2007      The Australian Linux Technical Conference!


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbWCIVHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWCIVHx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 16:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWCIVHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 16:07:53 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15491
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751543AbWCIVHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 16:07:51 -0500
Date: Thu, 09 Mar 2006 13:07:25 -0800 (PST)
Message-Id: <20060309.130725.42147030.davem@davemloft.net>
To: rlrevell@joe-job.com
Cc: bcollins@ubuntu.com, torvalds@osdl.org, zdzichu@irc.pl, gregkh@suse.de,
       bunk@stusta.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for
 2.6.16-rc5
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1141937556.13319.64.camel@mindpipe>
References: <Pine.LNX.4.64.0603091137180.18022@g5.osdl.org>
	<1141935002.6072.40.camel@grayson>
	<1141937556.13319.64.camel@mindpipe>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lee Revell <rlrevell@joe-job.com>
Date: Thu, 09 Mar 2006 15:52:35 -0500

> Ubuntu doesn't provide a UP 686 kernel?
> 
> Isn't there a performance hit running an SMP kernel on UP?

There is some cost, but it is mitigated by a patch they include
which nops out all the spinlocks when a UP system is detected.

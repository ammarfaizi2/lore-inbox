Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbUB0RAZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 12:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbUB0RAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 12:00:25 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:13239 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263049AbUB0RAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 12:00:21 -0500
Date: Fri, 27 Feb 2004 16:58:26 +0000
From: Dave Jones <davej@redhat.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: S390 block devs on !s390.
Message-ID: <20040227165826.GA9352@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040227135728.GA15016@redhat.com> <403F7431.80608@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403F7431.80608@backtobasicsmgmt.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 09:45:37AM -0700, Kevin P. Fleming wrote:
 > Dave Jones wrote:
 > 
 > >This is probably useless on x86 for eg..
 > >(Everything else in this file is dependant on some other s390 feature,
 > > so only this one shows up).  Too bad the drivers/s390/block stuff gets
 > >source'd at all on !s390.
 > 
 > Doesn't the config language support wrapping the entire KConfig file (or 
 > even a higher level one) with "if ARCH_S390"? All that does is add a 
 > "depends ARCH_S390" to everything in the file, but it would sure be a 
 > lot easier to maintain.

Sure, you force a bool to y if ARCH=S390 at the top.
That would work. Probably.

		Dave


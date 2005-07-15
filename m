Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbVGOFTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbVGOFTj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 01:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263208AbVGOFTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 01:19:39 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:48806 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S263117AbVGOFTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 01:19:38 -0400
Date: Thu, 14 Jul 2005 22:19:28 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Andi Kleen <ak@suse.de>
Cc: kenneth.w.chen@intel.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [announce] linux kernel performance project launch at
 sourceforge.net
Message-Id: <20050714221928.40ca2ce5.rdunlap@xenotime.net>
In-Reply-To: <20050714222748.GN23737@wotan.suse.de>
References: <p73y889kp5w.fsf@bragg.suse.de>
	<200507142224.j6EMOjg06251@unix-os.sc.intel.com>
	<20050714222748.GN23737@wotan.suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005 00:27:48 +0200 Andi Kleen wrote:

> > > Some oprofile listings from a few of the test runs would be also nice.
> > 
> > That is in the works.  We will upload profile data.  I'm having problem
> > with oprofile on some versions of kernel and that is being investigated
> > right now.
> 
> If you run statically compiled kernels you could as well use the
> old style readprofile.  It just doesn't work with modules.

It can be made to work with modules (and has been)[1],
but I'd just stick with not using modules, given a choice.

---
~Randy

[1] http://developer.osdl.org/rddunlap/modprofile/
(against 2.6.6)

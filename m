Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVCNQ4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVCNQ4l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 11:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVCNQ4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 11:56:41 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:18583 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261609AbVCNQ4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 11:56:25 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Date: Mon, 14 Mar 2005 08:55:18 -0800
User-Agent: KMail/1.7.2
Cc: David Lang <david.lang@digitalinsight.com>, Dave Jones <davej@redhat.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz> <20050314083717.GA19337@elf.ucw.cz>
In-Reply-To: <20050314083717.GA19337@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503140855.18446.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 14, 2005 12:37 am, Pavel Machek wrote:
> Perhaps we could have a rule like
>
> "non-experimental driver may only print out one line per actual
> device?"
>
> (and perhaps: dmesg output for boot going okay should fit on one screen).
>
> Or perhaps we should have warnings-like regression testing.
>
> "New kernel 2.8.17 came: 3 errors, 135 warnings, 1890 lines of dmesg
> junk".
>         Pavel

We already have the 'quiet' option, but even so, I think the kernel is *way* 
too verbose.  Someone needs to make a personal crusade out of removing 
unneeded and unjustified printks from the kernel before it really gets better 
though...

Jesse

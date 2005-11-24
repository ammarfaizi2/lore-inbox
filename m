Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932671AbVKXWrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbVKXWrH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 17:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVKXWrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 17:47:07 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:21147 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S932671AbVKXWqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 17:46:54 -0500
Date: Thu, 24 Nov 2005 14:48:25 -0800
From: thockin@hockin.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051124224825.GA20892@hockin.org>
References: <20051124133907.GG20775@brahms.suse.de> <1132842847.13095.105.camel@localhost.localdomain> <20051124142200.GH20775@brahms.suse.de> <1132845324.13095.112.camel@localhost.localdomain> <20051124145518.GI20775@brahms.suse.de> <m1psoqgk18.fsf@ebiederm.dsl.xmission.com> <20051124153635.GJ20775@brahms.suse.de> <20051124191207.GB2468@hockin.org> <20051124191445.GR20775@brahms.suse.de> <1132873934.13095.138.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132873934.13095.138.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 11:12:14PM +0000, Alan Cox wrote:
> On Iau, 2005-11-24 at 20:14 +0100, Andi Kleen wrote:
> > I proposed something like that - best with an ASCII string
> > ("First DIMM on the top left corner") But getting such stuff into BIOS 
> > is difficult and long winded.
> 
> Propose it the desktop management people and get it into the DMI
> standard. They already have entries for each memory slot, they already
> have entries for descriptive strings for connectors. In fact you may
> well be able to 'bend' the spec enough to do it as is.

There are enough fields that maybe one of them is loose enough to mean
this.  It doesn't help us convince mobo vendors to support it, though.

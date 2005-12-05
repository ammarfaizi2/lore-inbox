Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbVLEUJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVLEUJk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbVLEUJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:09:40 -0500
Received: from mail.dvmed.net ([216.237.124.58]:11405 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964793AbVLEUJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:09:39 -0500
Message-ID: <43949E6F.9050408@pobox.com>
Date: Mon, 05 Dec 2005 15:09:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Jiri Benc <jbenc@suse.cz>, Joseph Jezak <josejx@gentoo.org>,
       mbuesch@freenet.de, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051205190038.04b7b7c1@griffin.suse.cz> <4394892D.2090100@gentoo.org> <20051205195543.5a2e2a8d@griffin.suse.cz> <4394902C.8060100@pobox.com> <20051205195329.GB19964@redhat.com>
In-Reply-To: <20051205195329.GB19964@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Dave Jones wrote: > On Mon, Dec 05, 2005 at 02:08:28PM
	-0500, Jeff Garzik wrote: > > Jiri Benc wrote: > > >On Mon, 05 Dec 2005
	13:38:37 -0500, Joseph Jezak wrote: > > > > > >>We're not writing an
	entire stack. We're writing a layer that sits in > > >>between the
	current ieee80211 stack that's already present in the kernel > > >>and
	drivers that do not have a hardware MAC. Since ieee80211 is already > >
	>>in use in the kernel today, this seemed like a natural and useful > >
	>>extension to the existing code. I agree that it's somewhat wasteful
	to > > >>keep rewriting 802.11 stacks and we considered other options,
	but it > > >>seemed like a more logical choice to work with what was
	available and > > >>recommended than to use an external stack. > > > >
	> > > > >Unfortunately, the only long-term solution is to rewrite
	completely the > > >current in-kernel ieee80211 code (I would not call
	it a "stack") or > > >replace it with something another. The current
	code was written for > > >Intel devices and it doesn't support anything
	else - so every developer > > > > Patently false. > > > > ieee80211 is
	used by Intel. Some bits used by HostAP, which also > > duplicates a
	lot of ieee80211 code. And bcm43xx. And another couple > > drivers
	found in -mm or out-of-tree. > > Orinoco also uses it now no ? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Mon, Dec 05, 2005 at 02:08:28PM -0500, Jeff Garzik wrote:
>  > Jiri Benc wrote:
>  > >On Mon, 05 Dec 2005 13:38:37 -0500, Joseph Jezak wrote:
>  > >
>  > >>We're not writing an entire stack.  We're writing a layer that sits in 
>  > >>between the current ieee80211 stack that's already present in the kernel 
>  > >>and drivers that do not have a hardware MAC.  Since ieee80211 is already 
>  > >>in use in the kernel today, this seemed like a natural and useful 
>  > >>extension to the existing code.  I agree that it's somewhat wasteful to 
>  > >>keep rewriting 802.11 stacks and we considered other options, but it 
>  > >>seemed like a more logical choice to work with what was available and 
>  > >>recommended than to use an external stack.
>  > >
>  > >
>  > >Unfortunately, the only long-term solution is to rewrite completely the
>  > >current in-kernel ieee80211 code (I would not call it a "stack") or
>  > >replace it with something another. The current code was written for
>  > >Intel devices and it doesn't support anything else - so every developer
>  > 
>  > Patently false.
>  > 
>  > ieee80211 is used by Intel.  Some bits used by HostAP, which also 
>  > duplicates a lot of ieee80211 code.  And bcm43xx.  And another couple 
>  > drivers found in -mm or out-of-tree.
> 
> Orinoco also uses it now no ?

Just the headers, really.

	Jeff




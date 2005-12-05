Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVLETya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVLETya (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVLETy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:54:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17120 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964780AbVLETy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:54:27 -0500
Date: Mon, 5 Dec 2005 14:53:29 -0500
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jiri Benc <jbenc@suse.cz>, Joseph Jezak <josejx@gentoo.org>,
       mbuesch@freenet.de, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051205195329.GB19964@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, Jiri Benc <jbenc@suse.cz>,
	Joseph Jezak <josejx@gentoo.org>, mbuesch@freenet.de,
	linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
	NetDev <netdev@vger.kernel.org>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051205190038.04b7b7c1@griffin.suse.cz> <4394892D.2090100@gentoo.org> <20051205195543.5a2e2a8d@griffin.suse.cz> <4394902C.8060100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4394902C.8060100@pobox.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 02:08:28PM -0500, Jeff Garzik wrote:
 > Jiri Benc wrote:
 > >On Mon, 05 Dec 2005 13:38:37 -0500, Joseph Jezak wrote:
 > >
 > >>We're not writing an entire stack.  We're writing a layer that sits in 
 > >>between the current ieee80211 stack that's already present in the kernel 
 > >>and drivers that do not have a hardware MAC.  Since ieee80211 is already 
 > >>in use in the kernel today, this seemed like a natural and useful 
 > >>extension to the existing code.  I agree that it's somewhat wasteful to 
 > >>keep rewriting 802.11 stacks and we considered other options, but it 
 > >>seemed like a more logical choice to work with what was available and 
 > >>recommended than to use an external stack.
 > >
 > >
 > >Unfortunately, the only long-term solution is to rewrite completely the
 > >current in-kernel ieee80211 code (I would not call it a "stack") or
 > >replace it with something another. The current code was written for
 > >Intel devices and it doesn't support anything else - so every developer
 > 
 > Patently false.
 > 
 > ieee80211 is used by Intel.  Some bits used by HostAP, which also 
 > duplicates a lot of ieee80211 code.  And bcm43xx.  And another couple 
 > drivers found in -mm or out-of-tree.

Orinoco also uses it now no ?

		Dave


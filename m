Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbVHaQSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVHaQSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 12:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVHaQSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 12:18:53 -0400
Received: from mail.gmx.de ([213.165.64.20]:21666 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964858AbVHaQSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 12:18:52 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Subject: Re: 2.6.13-rc6-mm2 - breaks USB unplug
Date: Wed, 31 Aug 2005 18:18:49 +0200
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
References: <20050822213021.1beda4d5.akpm@osdl.org> <20050831141202.019edc99.Ballarin.Marc@gmx.de>
In-Reply-To: <20050831141202.019edc99.Ballarin.Marc@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508311818.50307.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

On Wednesday 31 August 2005 14.12, Marc Ballarin wrote:
> Hi,
> 
> -rc6-mm2 breaks USB unplug for me. Happens with every USB device,
> gcc-3.3.5 and gcc-3.4.4 as well as preempt and non-preempt and is 100%
> reproducible.
> -rc6-mm1 seems fine.
> 
> Reverting the following part of
> driver-core-fix-bus_rescan_devices-race.patch
> fixes this for me:
> [snip]

see http://marc.theaimsgroup.com/?l=linux-kernel&m=112481438512222&w=2

rgds
-daniel

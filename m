Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752073AbWCIXrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbWCIXrP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbWCIXrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:47:15 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:18601 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1752073AbWCIXrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:47:14 -0500
X-IronPort-AV: i="4.02,180,1139212800"; 
   d="scan'208"; a="313140698:sNHT31516468"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight subnet management
X-Message-Flag: Warning: May contain useful information
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	<adalkvjfbo0.fsf@cisco.com>
	<1141947581.10693.45.camel@serpentine.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 15:47:11 -0800
In-Reply-To: <1141947581.10693.45.camel@serpentine.pathscale.com> (Bryan O'Sullivan's message of "Thu, 09 Mar 2006 15:39:41 -0800")
Message-ID: <adamzfzdvuo.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 23:47:11.0650 (UTC) FILETIME=[C9075820:01C643D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Three reasons.
 > 
 >       * OpenSM wasn't usable when we wrote our SMA.  We have customers
 >         using ours now, so we have to support it.

Huh?  What does OpenSM working or not have to do with the SMA?

 >       * Our SMA does some setup for the layered ethernet emulation
 >         driver.
 >       * Our SMA works without an IB stack of any kind present.

That's fine.  So then I guess the question is, why can't you use your
SMA all the time?

And does that mean that the verbs SMA doesn't support ethernet
emulation, so you can't use ethernet emulation and verbs at the same time?

 - R.

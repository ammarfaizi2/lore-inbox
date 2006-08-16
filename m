Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWHPJPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWHPJPA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWHPJPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:15:00 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:2243 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751047AbWHPJO7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:14:59 -0400
Date: Wed, 16 Aug 2006 11:11:54 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Daniel Drake <dsd@gentoo.org>, Peter M <peter.mdk@gmail.com>,
       linux-kernel@vger.kernel.org, ansla80@yahoo.com
Subject: Re: Oops in 2.6.17.7 running multiple eth bridges [r8169?]
Message-ID: <20060816091154.GA9477@electric-eye.fr.zoreil.com>
References: <31296a430608101034v2ecfbf8an66510427da49af4d@mail.gmail.com> <44E1A93E.8020701@gentoo.org> <20060815110743.593047a4@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815110743.593047a4@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> :
[...]
> If you are using jumbo frames, then most Ethernet driver's are more prone
> to allocation failure because they can't get contiguous memory. Some drivers
> are being changed to do fragmented receive, but the support is sketchy at this
> point.

The reports exhibit 0 order allocation failure. The r8169 should stand it, at least temporarily.
No idea how the nvdia stuff will behave under low memory with preempt and ht enabled.

I'll look at Peter's info files at the end of the week, when I'm back from 33k modem. With 128Mo
and 8 interfaces, his system is not trivial.

-- 
Ueimor

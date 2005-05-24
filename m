Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVEXCMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVEXCMX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 22:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVEXCMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 22:12:23 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.4.200]:27455 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261299AbVEXCMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 22:12:16 -0400
Date: Mon, 23 May 2005 22:12:15 -0400
From: Nick Orlov <bugfixer@list.ru>
Subject: Re: 2.6.12-rc4-mm[12] - ULOG problem
In-reply-to: <20050519031049.GA18130@nikolas.hn.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Mail-followup-to: linux-kernel@vger.kernel.org, akpm@osdl.org
Message-id: <20050524021215.GA4237@nikolas.hn.org>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.9i
References: <20050519031049.GA18130@nikolas.hn.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 11:10:49PM -0400, Nick Orlov wrote:
> ipt_ULOG fails to load starting from 2.6.12-rc4-mm1 with the following
> error message:
> 
> 
> FATAL: Error inserting ipt_ULOG (/lib/modules/2.6.12-rc4-mm1-2/kernel/net/ipv4/netfilter/ipt_ULOG.ko): Cannot allocate memory
> 
> rc3-mm3 works fine.
> 

I'd like to confirm that reverting the following connector related patches
solves the problem for me.

1.patch -> ../full/broken-out/connector-add-a-fork-connector-build-fix.patch
2.patch -> ../full/broken-out/connector-add-a-fork-connector.patch
3.patch -> ../full/broken-out/connector-export-initialization-flag.patch
4.patch -> ../full/broken-out/connector-warning-fixes.patch
5.patch -> ../full/broken-out/connector.patch


Thank you,
	Nick Orlov.

-- 
With best wishes,
	Nick Orlov.


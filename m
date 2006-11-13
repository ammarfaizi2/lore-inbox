Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755280AbWKMREf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280AbWKMREf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755282AbWKMREf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:04:35 -0500
Received: from h155.mvista.com ([63.81.120.155]:29199 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1755280AbWKMREd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:04:33 -0500
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To: mingo@elte.hu
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t in latency_trace.c
Date: Mon, 13 Nov 2006 20:06:06 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@linux-mips.org,
       dwalker@mvista.com, khilman@mvista.com
References: <200611130023.12126.sshtylyov@ru.mvista.com>
In-Reply-To: <200611130023.12126.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611132006.07086.sshtylyov@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Monday 13 November 2006 00:23, Sergei Shtylyov wrote:
> In addition to clock wrap check being falsely triggered with 32-bit
> cycles_t, as noticed to Kevin Hilman, there's another issue: using %Lx
> format to print 32-bit values warrants erroneous values on 32-bit machines
> like ARM and PPC32.

   There's many more warnings with other options turned on, so I'll post an updated patch soon...

WBR, Sergei


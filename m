Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756329AbWKVS00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756329AbWKVS00 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756339AbWKVS00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:26:26 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:15571 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1756329AbWKVS0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:26:25 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: William Cohen <wcohen@redhat.com>
Subject: Re: 2.6.19-rc5: known regressions (v3)
Date: Wed, 22 Nov 2006 19:26:42 +0100
User-Agent: KMail/1.9.5
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>, phil.el@wanadoo.fr, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@redhat.com>,
       oprofile-list@lists.sourceforge.net,
       Stephen Hemminger <shemminger@osdl.org>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <200611221128.05769.dada1@cosmosbay.com> <45649166.8060209@redhat.com>
In-Reply-To: <45649166.8060209@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611221926.43122.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 November 2006 19:05, William Cohen wrote:

> You will also need another patch checked into the oprofile cvs last week
> mentioned:
>
> http://sourceforge.net/mailarchive/message.php?msg_id=35422937
>
> -Will

Thank you William.

I confirm that CVS oprofile version + patches you gave here works with 
linux-2.6.16-rc6 on i386, regardless of disabling nmi_watchdog  (adding or 
not nmi_watchdog=0 in boot params)

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbVKBNrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVKBNrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbVKBNrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:47:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:61312 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965021AbVKBNrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:47:02 -0500
Date: Wed, 2 Nov 2005 14:47:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: =?utf-8?B?UGF3ZcWC?= Sikora <pluto@agmk.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.14-rt1] slowdown / oops.
Message-ID: <20051102134723.GB13468@elte.hu>
References: <200511021420.28104.pluto@agmk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200511021420.28104.pluto@agmk.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,NORMAL_HTTP_TO_IP autolearn=disabled SpamAssassin version=3.0.4
	0.1 NORMAL_HTTP_TO_IP      URI: Uses a dotted-decimal IP address in URL
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paweł Sikora <pluto@agmk.net> wrote:

> 2).
> During `scp bigfile to another machine` I get an oops:
> http://149.156.124.14/~pluto/tmp/2.6.14-rt2-oops.jpg [796 kB]

is routing to that other box covered by any of the iptables NAT rules?  
Does the crash happen if you turn off all firewalling via "iptables -F"?

	Ingo

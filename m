Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbULNW2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbULNW2l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbULNW0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:26:42 -0500
Received: from opersys.com ([64.40.108.71]:10250 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261697AbULNWYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:24:32 -0500
Message-ID: <41BF69EA.7050003@opersys.com>
Date: Tue, 14 Dec 2004 17:32:10 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: LTT <ltt@shafik.org>, LTT-Dev <ltt-dev@shafik.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] LTT 0.9.6pre4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is to let everyone know that there's a new LTT release. This
should be the final LTT candidate before I make an official 0.9.6
release, so please test this out and report any problems. This
release includes patches for vanilla 2.6.9, so testing should be
rather straight-forward.

I would like to thank Tim Bird of the CE Linux Forum for going
through the LTT-dev mailing list archives and picking up some of
the contributions that were posted there, and integrating it all.

For this release, I've followed Andrew Morton's advice, and have
proceeded with a namespace cleanup of the kernel code. So,
instead of trace statements being like this:
	TRACE_SCHEDCHANGE(prev, next);
they have the more mainstream form of:
	ltt_ev_schedchange(prev, next);

Here are the highlights of the most important additions since the
opening of the 0.9.6preX branch:
     * Lockless logging (relayfs)
     * Per-CPU buffering
     * TSC timestamping
     * Use of relayfs for buffering and user-space interfacing
     * Code cleanup for adhering to kernel coding standards
     * ARM port

Enjoy,

Karim Yaghmour
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

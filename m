Return-Path: <linux-kernel-owner+w=401wt.eu-S1751854AbXARKT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbXARKT5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 05:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbXARKT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 05:19:56 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:58516 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbXARKT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 05:19:56 -0500
Date: Thu, 18 Jan 2007 11:18:01 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: "H. Peter Anvin" <hpa@zytor.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Introduce two new maturlty levels:  DEPRECATED and
 OBSOLETE.
In-Reply-To: <Pine.LNX.4.64.0701171706330.4353@CPE00045a9c397f-CM001225dbafb6>
Message-ID: <Pine.LNX.4.61.0701181116250.19740@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0701171616140.4060@CPE00045a9c397f-CM001225dbafb6>
 <45AE9B85.7090608@zytor.com> <Pine.LNX.4.64.0701171706330.4353@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Wed, 17 Jan 2007, H. Peter Anvin wrote:
>
>> DEPRECATED should presumably default to Y; OBSOLETE to n.
>
>crap, now i see what you were getting at -- i forgot to assign
>defaults.  i'll resubmit, but i'll wait for anyone to suggest any
>better help content if they have a better idea.

Well... _maybe_ documentation/scheduled-removal.txt (or whatever it is 
called) could now be merged into the kconfig options and help text. Or 
maybe not, to keep it easy to track deprecated code.

Well, even if scheduled-removal.txt stays, you could submit a 2nd patch 
putting OBSOLETE and DEPRECATED tags to the Kconfig options listed in 
scheduled-removal.txt, so that kconfig+sched are in sync.


	-`J'
-- 

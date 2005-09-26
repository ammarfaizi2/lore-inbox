Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVIZGl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVIZGl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 02:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVIZGl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 02:41:57 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58084 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932409AbVIZGl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 02:41:57 -0400
Date: Mon, 26 Sep 2005 08:42:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RT bug with 2.6.13-rt4 and 3c905c tornado
Message-ID: <20050926064246.GC3472@elte.hu>
References: <200509201046.17818.Serge.Noiraud@bull.net> <20050920085532.GA19807@elte.hu> <200509221554.02765.Serge.Noiraud@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509221554.02765.Serge.Noiraud@bull.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


could you try -rt2, do the lockups still occur? If it locks up then 
could you try one more thing: boot -rt2 _without_ the NMI watchdog 
enabled. Maybe the NMI watchdog itself got broken. (it happens 
occasionally)

	Ingo

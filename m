Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVLFG6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVLFG6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 01:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVLFG6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 01:58:55 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:6277 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751437AbVLFG6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 01:58:54 -0500
Date: Tue, 6 Dec 2005 07:59:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Carlos =?iso-8859-1?Q?Mart=EDn?= <carlos@cmartin.tk>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.15-rc5-mm1
Message-ID: <20051206065911.GA24592@elte.hu>
References: <20051204232153.258cd554.akpm@osdl.org> <200512050749.03673.carlos@cmartin.tk> <20051206140453.11e72d89.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206140453.11e72d89.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > Dec 27 14:32:45 kiopa kernel: BUG: soft lockup detected on CPU#1!
> > Dec 27 14:32:45 kiopa kernel: CPU 1:

> At a guess I'd say the new ktimeout code is playing up.

hm, the ktimeout patches only rename, they do not change any code or 
semantics.

	Ingo

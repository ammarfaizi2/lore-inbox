Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262883AbVAKVqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbVAKVqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbVAKVp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:45:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27061 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262883AbVAKVmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:42:47 -0500
Date: Tue, 11 Jan 2005 22:41:52 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Matt Mackall <mpm@selenic.com>, Chris Wright <chrisw@osdl.org>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111214152.GA17943@devserv.devel.redhat.com>
References: <87mzvkxxck.fsf@sulphur.joq.us> <20050110212019.GG2995@waste.org> <87d5wc9gx1.fsf@sulphur.joq.us> <20050111195010.GU2940@waste.org> <871xcr3fjc.fsf@sulphur.joq.us> <20050111200549.GW2940@waste.org> <1105475349.4295.21.camel@krustophenia.net> <20050111124707.J10567@build.pdx.osdl.net> <20050111212823.GX2940@waste.org> <1105479495.4295.61.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105479495.4295.61.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 04:38:14PM -0500, Lee Revell wrote:
> Yes but a bug in an app running as root can trash the filesystem.  The
> worst you can do with RT privileges is lock up the machine.

several filesystem and IO threads run at prio -10 but not RT.
That makes me a bit less sure of your statement....

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVAGSEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVAGSEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVAGSEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:04:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:39627 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261375AbVAGSB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:01:58 -0500
Date: Fri, 7 Jan 2005 10:01:57 -0800
From: Chris Wright <chrisw@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107100157.F2357@build.pdx.osdl.net>
References: <20050107130407.GA8119@infradead.org> <200501071416.j07EGoa4018080@localhost.localdomain> <20050107142637.GB20398@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050107142637.GB20398@devserv.devel.redhat.com>; from arjanv@redhat.com on Fri, Jan 07, 2005 at 03:26:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven (arjanv@redhat.com) wrote:
> eh no. It defaults to zero, but if you increase it for a specific user, that
> user is allowed to mlock more.

Actually, I think it defaults to 32k to keep gpg happy (at least in
mainline) ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264491AbTFIQEg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 12:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTFIQEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 12:04:36 -0400
Received: from air-2.osdl.org ([65.172.181.6]:63920 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264491AbTFIQEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 12:04:35 -0400
Date: Mon, 9 Jun 2003 09:19:48 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New system device API
In-Reply-To: <20030607203304.GB667@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0306090918200.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> System devices may be special, but they should not be so special not
> to require u32 level.  All current system devices need to be
> suspended last, but that's pure coincidence, I believe.

Fine. Then show me a device that needs a two-stage suspend. I'm not going 
to add an extra method and semantics for something that isn't going to 
currently be used by anyone.

	-pat


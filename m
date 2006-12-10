Return-Path: <linux-kernel-owner+w=401wt.eu-S1762449AbWLJT5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762449AbWLJT5T (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 14:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762450AbWLJT5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 14:57:19 -0500
Received: from twin.jikos.cz ([213.151.79.26]:46410 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762440AbWLJT5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 14:57:18 -0500
Date: Sun, 10 Dec 2006 20:57:00 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Jiri Slaby <jirislaby@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, mingo@redhat.com, neilb@cse.unsw.edu.au,
       linux-raid@vger.kernel.org
Subject: Re: oops on 2.6.19-rc6-mm2: deref of 0x28 at permission+0x7
In-Reply-To: <Pine.LNX.4.64.0612102027350.1665@twin.jikos.cz>
Message-ID: <Pine.LNX.4.64.0612102054351.1665@twin.jikos.cz>
References: <457A0F4C.9060601@gmail.com> <Pine.LNX.4.64.0612102027350.1665@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2006, Jiri Kosina wrote:

> this nash thing is exactly the command which triggers a bit different 
> oops in my case. On my side, the oops is fully reproducible. If you 
> manage to make your case also reproducible, could you please try to 
> revert md-change-lifetime-rules-for-md-devices.patch? This made the oops 
> vanish in my case. I think Neil is working on it.

And I forgot to add reference to the original thread - 
http://lkml.org/lkml/2006/11/28/248

-- 
Jiri Kosina

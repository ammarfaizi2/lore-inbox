Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVBLW3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVBLW3b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 17:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVBLW3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 17:29:31 -0500
Received: from one.firstfloor.org ([213.235.205.2]:901 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261207AbVBLW3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 17:29:30 -0500
To: linux@horizon.com
Cc: arjan@infradead.org, bunk@stusta.de, chrisw@osdl.org, davem@redhat.com,
       hlein@progressive-comp.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, shemminger@osdl.org, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
References: <20050131201141.GA4879@elte.hu>
	<20050131232735.11236.qmail@science.horizon.com>
From: Andi Kleen <ak@muc.de>
Date: Sat, 12 Feb 2005 23:29:28 +0100
In-Reply-To: <20050131232735.11236.qmail@science.horizon.com> (linux@horizon.com's
 message of "31 Jan 2005 23:27:35 -0000")
Message-ID: <m11xblif93.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com writes:
>
> (The homebrew 15-bit block cipher in this code does show how much the
> world needs a small block cipher for some of these applications.)

Doesn't TEA fill this niche? It's certainly used for this in the Linux
kernel, e.g. in reiserfs (although I have my doubts it is really useful
there) 

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbULLWxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbULLWxN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 17:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbULLWxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 17:53:13 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:36362 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262160AbULLWxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 17:53:11 -0500
Date: Sun, 12 Dec 2004 23:37:40 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: how to detect a 32 bit process on 64 bit kernel
Message-ID: <20041212223740.GF17946@alpha.home.local>
References: <20040901072245.GF13749@mellanox.co.il> <20040903080058.GB2402@wotan.suse.de> <20040907104017.GB10096@mellanox.co.il> <20040907121418.GC25051@wotan.suse.de> <20041212215110.GA11451@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041212215110.GA11451@mellanox.co.il>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2004 at 11:51:10PM +0200, Michael S. Tsirkin wrote:
> Hello!
> Is there a reliable way e.g. on x86-64 (or ia64, or any other
> 64-bit system), from the char device driver,
> to find out that I am running an operation in the context of a 32-bit
> task?

aren't there informations in /proc/$$/maps or other things which will
change their format or contents in 32 or 64 bits addressing, which would
help you detect the mode you're currently running ?

Willy


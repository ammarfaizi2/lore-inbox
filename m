Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936225AbWLDMVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936225AbWLDMVc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936230AbWLDMVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:21:32 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:64137 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S936225AbWLDMVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:21:31 -0500
Date: Mon, 4 Dec 2006 13:21:29 +0100
From: bert hubert <bert.hubert@netherlabs.nl>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] lock stat for 2.6.19-rt1
Message-ID: <20061204122129.GA2626@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Bill Huey <billh@gnuppy.monkey.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
References: <20061204015323.GA28519@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204015323.GA28519@gnuppy.monkey.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2006 at 05:53:23PM -0800, Bill Huey wrote:

> [8264, 996648, 0]		{inode_init_once, fs/inode.c, 196}
> [8552, 996648, 0]		{inode_init_once, fs/inode.c, 193}

Impressive, Bill!

How tightly is your work bound to -rt? Iow, any chance of separating the
two? Or should we even want to?

> The first column is the number of the times that object was contented against.
> The second is the number of times this lock object was initialized. The third
> is the annotation scheme that directly attaches the lock object (spinlock,
> etc..) in line with the function initializer to avoid the binary tree lookup.

I don't entirely get the third item, can you elaborate a bit?

Do you have a feeling of the runtime overhead?

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbULOQ5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbULOQ5H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbULOQ5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:57:07 -0500
Received: from news.suse.de ([195.135.220.2]:28357 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262394AbULOQ5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:57:04 -0500
Date: Wed, 15 Dec 2004 17:57:03 +0100
From: Andi Kleen <ak@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andi Kleen <ak@suse.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
       gordon.jin@intel.com
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041215165703.GC26772@wotan.suse.de>
References: <20041215065650.GM27225@wotan.suse.de> <200412151446.01913.arnd@arndb.de> <20041215161218.GA26772@wotan.suse.de> <200412151745.32053.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412151745.32053.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you mean it should call back
> from its private ioctl_compat() function to the global ioctl32_hash_table[]
> lookup?

Yes.

Some ioctl paths already work this way, e.g. in the block layer.

-Andi

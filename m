Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263263AbTDRV7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 17:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTDRV7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 17:59:16 -0400
Received: from ool-4352eb9e.dyn.optonline.net ([67.82.235.158]:63883 "EHLO
	nikolas.hn.org") by vger.kernel.org with ESMTP id S263263AbTDRV7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 17:59:15 -0400
Date: Fri, 18 Apr 2003 18:10:29 -0400
From: Nick Orlov <bugfixer@list.ru>
To: Christoph Hellwig <hch@infradead.org>,
       Andrei Ivanov <andrei.ivanov@ines.ro>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm4
Message-ID: <20030418221029.GA3956@nikolas>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrei Ivanov <andrei.ivanov@ines.ro>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50L0.0304182236480.1931-100000@webdev.ines.ro> <20030418205403.GA3366@nikolas> <20030418225447.A8626@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20030418225447.A8626@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 10:54:47PM +0100, Christoph Hellwig wrote:
> On Fri, Apr 18, 2003 at 04:54:03PM -0400, Nick Orlov wrote:
> > In my case sshd was not able to allocate pts...
> > Actually it was not possible to allocate pts under 2.5.67-mm4 at all.
> 
> do you have the devpts filesystem mounted on /dev/pts/ ?

No, I don't.
I'm using devfs and it works perfectly under 2.5.67-mm3.

Below is part of my .config related to devpts and devfs:

nick@nikolas:/boot$ egrep "DEVFS|DEVPTS" config-2.5.67-mm4-1
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y

BTW, system is Debian/unstable, daily updated.

Thanks,
	Nick.

-- 
With best wishes,
	Nick Orlov.


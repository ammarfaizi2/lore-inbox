Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVADAhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVADAhe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVADAe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:34:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:23735 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262036AbVADAVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:21:16 -0500
Date: Mon, 3 Jan 2005 16:21:12 -0800
From: Chris Wright <chrisw@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: pin files in memory after read
Message-ID: <20050103162112.C469@build.pdx.osdl.net>
References: <20050103180718.GA22138@suse.de> <1104776680.4192.20.camel@laptopd505.fenrus.org> <20050104000457.GA23361@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050104000457.GA23361@suse.de>; from olh@suse.de on Tue, Jan 04, 2005 at 01:04:57AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Olaf Hering (olh@suse.de) wrote:
> with an absolute path. Any idea how to get to the relative path like
> "./x" and print an absolute path for these files?

d_path() will give that to you, once you've resolved the path to dentry
and vfsmount pair.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

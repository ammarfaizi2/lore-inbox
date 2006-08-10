Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWHJJUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWHJJUY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWHJJUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:20:24 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:32397 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751479AbWHJJUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:20:23 -0400
Date: Thu, 10 Aug 2006 11:20:22 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/5] Register ext3dev filesystem
Message-ID: <20060810092021.GB11361@harddisk-recovery.com>
References: <1155172642.3161.74.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155172642.3161.74.camel@localhost.localdomain>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 06:17:22PM -0700, Mingming Cao wrote:
> Register ext4 filesystem as ext3dev filesystem in kernel.

Why confuse users with the name "ext3dev"? If a filesystem lives in
fs/blah/, it's registered as "blah" and can be mounted with "-t blah".
Just register the filesystem as "ext4" and mark it "EXPERIMENTAL" in
Kconfig.

Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands

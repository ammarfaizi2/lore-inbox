Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbTDIU6y (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 16:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTDIU6y (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 16:58:54 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17822
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263804AbTDIU6x (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 16:58:53 -0400
Subject: RE: questions regarding Journalling-FSes and w-cache reordering
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "'Oliver S.'" <Follow.Me@gmx.net>
In-Reply-To: <785F348679A4D5119A0C009027DE33C102E0D0B1@mcoexc04.mlm.maxtor.com>
References: <785F348679A4D5119A0C009027DE33C102E0D0B1@mcoexc04.mlm.maxtor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049919134.10871.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Apr 2003 21:12:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-09 at 20:52, Mudama, Eric wrote:
> ATA hard drives are allowed to reorder/merge/etc their write caches if write
> cache is enabled.  With write caching enabled, there is no guarantee that
> dirty data will be flushed in any specific order, nor does the ATA protocol
> support any such ordering beyond the global flush cache command.

To cheer people up further by the way, not all ATA drives support cache
flush, some drives dont support write cache disable and others implement
write/verify as write.

So basically you can't do it.


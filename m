Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270736AbTG0KyN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 06:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270737AbTG0KyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 06:54:13 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46211
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270736AbTG0KyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 06:54:08 -0400
Subject: Re: [TRIVIAL] use ext2/ext3 consistently in Kconfig
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030726195722.GB16160@louise.pinerecords.com>
References: <20030726195722.GB16160@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059303927.12758.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jul 2003 12:05:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-26 at 20:57, Tomas Szepe wrote:
> $subj + also clarify what fs versions the current reiser module supports.
> Patch against -bk3.          


> This is the journaling version of the Second extended file system
-         (often called ext3), the de facto standard Linux file system
+         (often called ext2), the de facto standard Linux file system
          (method to organize files on a storage device) for hard disks.

It is called ext3 not ext2. This change is dubious (actually the big
problem is it is totally unclear what we are discussing the name of.
How about

  Ext3 is the journalling versions of the second extended file system
(ext2). Ext2 was the former de-facto standard Linux file system. Ext3
uses the same on disk layout but with a journal.
 ...


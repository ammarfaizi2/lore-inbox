Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266726AbUGUUmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266726AbUGUUmj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 16:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266731AbUGUUmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 16:42:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:7920 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266726AbUGUUmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 16:42:38 -0400
Subject: Re: Jffs2 file system
From: Josh Boyer <jdub@us.ibm.com>
To: Lei Yang <leiyang@nec-labs.com>
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>,
       "Kernelnewbies (E-mail)" <kernelnewbies@nl.linux.org>
In-Reply-To: <951A499AA688EF47A898B45F25BD8EE80126D4D3@mailer.nec-labs.com>
References: <951A499AA688EF47A898B45F25BD8EE80126D4D3@mailer.nec-labs.com>
Content-Type: text/plain
Message-Id: <1090442506.13986.19.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 21 Jul 2004 15:41:46 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-21 at 14:48, Lei Yang wrote:
> Hello,
> 
> Can I use jffs2 on a ramdisk? Is jffs2 only designed to be used on flash memory devices rather than RAM devices?
> What about cramfs?

jffs2 needs an MTD device, so it can be run on any medium that MTD
supports.  There are some MTD drivers for RAM based devices.

The MTD mailing list might be able to help you more
(linux-mtd@lists.infradea.org).

josh


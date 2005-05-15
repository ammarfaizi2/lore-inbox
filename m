Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVEOGbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVEOGbg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 02:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVEOGbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 02:31:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:3278 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261518AbVEOGbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 02:31:35 -0400
Subject: Re: [PATCH 7/8] ppc64: SPU file system
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <200505141505.08999.arnd@arndb.de>
References: <200505132117.37461.arnd@arndb.de>
	 <200505132129.07603.arnd@arndb.de> <20050514074524.GC20021@kroah.com>
	 <200505141505.08999.arnd@arndb.de>
Content-Type: text/plain
Date: Sun, 15 May 2005 16:29:06 +1000
Message-Id: <1116138546.5095.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Using a write call instead of read makes the interface even more
> complicated because it would require the user to read the status
> from a separate file after write returns to check what needs to
> be done and then use lseek() or yet another file to access the
> instruction pointer.

Why not just write(pc) to start and read back status from the same
file ?

Ben.



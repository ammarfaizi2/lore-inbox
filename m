Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUHINDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUHINDx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 09:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266550AbUHINDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 09:03:53 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:27834 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266547AbUHINDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 09:03:52 -0400
Date: Mon, 9 Aug 2004 06:03:59 -0700
From: Paul Jackson <pj@sgi.com>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Problem] 2.6.8-rc3: usb-storage devices are read-only (NOT
 related to iocharset)
Message-Id: <20040809060359.5be7c11f.pj@sgi.com>
In-Reply-To: <200408082208.02328.rjwysocki@sisk.pl>
References: <200408082157.35469.rjwysocki@sisk.pl>
	<200408082208.02328.rjwysocki@sisk.pl>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been mounting my vfat /boot/efi elilo (this is on an SN2, which
uses ia64 boot conventions) boot partition read-write by doing:

	mount -o remount,rw /boot/efi
 
after it comes up mounted read-only.  Does that help?  This is on
2.6.8-rc2-mm2.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

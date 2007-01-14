Return-Path: <linux-kernel-owner+w=401wt.eu-S1750783AbXANASK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbXANASK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 19:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbXANASK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 19:18:10 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44804 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750749AbXANASJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 19:18:09 -0500
Date: Sun, 14 Jan 2007 00:27:56 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org,
       Gerd Hoffmann <kraxel@suse.de>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] [patch 02/20] XEN-paravirt: Add a flag to allow the
 VGA console to be disabled
Message-ID: <20070114002756.5ee2b807@localhost.localdomain>
In-Reply-To: <20070113014647.240188180@goop.org>
References: <20070113014539.408244126@goop.org>
	<20070113014647.240188180@goop.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007 17:45:41 -0800
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Add a flag to allow the VGA console to be disabled.  The VGA code will
> spin forever if there isn't any real VGA hardware, which will happen
> under Xen.

If it is doing this then the real bug should be fixed so that it doesn't
hang in the same way on a physical system which has no VGA.

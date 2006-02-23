Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751756AbWBWRaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWBWRaq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWBWRap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:30:45 -0500
Received: from [81.2.110.250] ([81.2.110.250]:7385 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751756AbWBWRap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:30:45 -0500
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
In-Reply-To: <200602231820.50384.ak@suse.de>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
	 <1140713001.4672.73.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
	 <200602231820.50384.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 17:34:11 +0000
Message-Id: <1140716051.4952.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-02-23 at 18:20 +0100, Andi Kleen wrote:
> BTW I have been also pondering some time to really trust e820 and not
> forcibly reserve 640K-1MB on 64bit.  That code was inherited from i386,
> but probably never made too much sense

Depends if you want your boot video stuff to work, and vga space, and
also how the ISA hole is used, some chipsets seem to use the RAM that
would be there remapped elsewhere as SMM ram.

Alan


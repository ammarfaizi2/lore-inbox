Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbUKDS24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbUKDS24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbUKDSRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:17:42 -0500
Received: from peabody.ximian.com ([130.57.169.10]:26811 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262357AbUKDSQX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:16:23 -0500
Subject: Re: netlink vs kobject_uevent ordering
From: Robert Love <rml@novell.com>
To: Greg KH <greg@kroah.com>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       davem@redhat.com, herbert@gondor.apana.org.au,
       Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20041104180550.GA16744@kroah.com>
References: <20041104154317.GA1268@krispykreme.ozlabs.ibm.com>
	 <20041104180550.GA16744@kroah.com>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 13:13:53 -0500
Message-Id: <1099592033.31022.138.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 10:05 -0800, Greg KH wrote:

> So, Robert and Kay, any thoughts as to how this has ever worked at boot
> time in the past?

Weird.  I don't have a clue, but clearly it did work.

Similar thing here:

	c04b60cc t __initcall_kobject_uevent_init
	c04b60d0 t __initcall_netlink_proto_init

Dunno why it ever worked, but it at least used to.

	Robert Love




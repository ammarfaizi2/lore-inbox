Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbUKLCqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbUKLCqD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 21:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUKLCqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 21:46:03 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:44713 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262421AbUKLCqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 21:46:00 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Fix usage of setup_arg_pages() in IA64, MIPS, S390 and Sparc64
Date: Thu, 11 Nov 2004 21:44:12 -0500
User-Agent: KMail/1.7
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, arnd@arndb.de,
       linux-kernel@vger.kernel.org
References: <2555.1100085859@redhat.com> <20041111143623.05f1d92a.davem@davemloft.net>
In-Reply-To: <20041111143623.05f1d92a.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411112144.12672.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 11, 2004 5:36 pm, David S. Miller wrote:
> On Wed, 10 Nov 2004 11:24:19 +0000
>
> David Howells <dhowells@redhat.com> wrote:
> > The attached patch fixes the usage of setup_arg_pages() in the IA64,
> > MIPS, S390 and Sparc64 arches. This function now takes an extra
> > parameter: the initial top of stack. This is useful in uClinux when
> > there's no fixed location to which the stack pointer can be initialised.
>
> The sparc64 part looks perfectly fine to me.

And ia64 builds and boots with the change.

Jesse

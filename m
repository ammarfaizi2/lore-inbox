Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268963AbUJEKjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268963AbUJEKjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 06:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268947AbUJEKjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 06:39:24 -0400
Received: from ozlabs.org ([203.10.76.45]:1771 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268963AbUJEKjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 06:39:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16738.31164.464250.638432@cargo.ozlabs.ibm.com>
Date: Tue, 5 Oct 2004 20:38:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev@lists.linuxppc.org,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PPC64] xmon sparse cleanups
In-Reply-To: <20041005064255.GF3695@zax>
References: <20041005064255.GF3695@zax>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson writes:

> Andrew, please apply:
> 
> This patch removes many sparse warnings from the xmon code.  Mostly
> K&R function declarations and 0-instead-of-NULLs.

The trouble with this patch is that it makes ppc-opc.c diverge from
the version in binutils, which is where it came from.  I'd rather keep
it as close as possible to that version.  I have no problem with the
changes to the other files.

Paul.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269370AbUJMPwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269370AbUJMPwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 11:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269377AbUJMPwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 11:52:33 -0400
Received: from havoc.gtf.org ([69.28.190.101]:26001 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S269370AbUJMPw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 11:52:29 -0400
Date: Wed, 13 Oct 2004 11:49:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@linux.kernel.org
Subject: Re: PATCH: IDE generic tweak
Message-ID: <20041013154916.GA6832@havoc.gtf.org>
References: <1097677476.4764.9.camel@localhost.localdomain> <20041013153152.GA5458@havoc.gtf.org> <1097678363.4696.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097678363.4696.16.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 03:39:33PM +0100, Alan Cox wrote:
> On Mer, 2004-10-13 at 16:31, Jeff Garzik wrote:
> > > Comments ?
> > 
> > nVidia and others have been pushing for a similar module for libata...
> > at least make sure one doesn't preclude the other.
> 
> libata can't do ATAPI and doesn't know about PATA errata so it's not
> useful in libata yet.

The people requesting the feature quite disagree :)

nVidia for example specifically wanted it because future __SATA__
hardware will appear at the legacy IDE addresses, and end users were
requesting for similar reasons.

They have configurations both today and in the future where they want to
use this in libata.

	Jeff




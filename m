Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269146AbUJMPeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269146AbUJMPeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 11:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269190AbUJMPeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 11:34:24 -0400
Received: from havoc.gtf.org ([69.28.190.101]:13456 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S269146AbUJMPeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 11:34:16 -0400
Date: Wed, 13 Oct 2004 11:31:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@linux.kernel.org
Subject: Re: PATCH: IDE generic tweak
Message-ID: <20041013153152.GA5458@havoc.gtf.org>
References: <1097677476.4764.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097677476.4764.9.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 03:24:48PM +0100, Alan Cox wrote:
> This allows the user to force ide-generic to claim any remaining
> IDE_STORAGE_CLASS devices. It isnt a good default to turn on because of
> loadable driver modules and confusion with SATA however it is very
> useful faced with a mainboard device that isn't supported any other way.
> Note that the entry has to come last - if it looks OK I'll comment that
> a bit more and update the option docs.
> 
> Comments ?

nVidia and others have been pushing for a similar module for libata...
at least make sure one doesn't preclude the other.

	Jeff




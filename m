Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbUC3BiK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 20:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbUC3BiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 20:38:10 -0500
Received: from mail.kroah.org ([65.200.24.183]:7884 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263464AbUC3BiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 20:38:06 -0500
Date: Mon, 29 Mar 2004 17:37:45 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (8/10): zfcp fixes.
Message-ID: <20040330013745.GA15081@kroah.com>
References: <OF2D02D7FE.D57DABBB-ONC1256E66.0036A8C5-C1256E66.00373A2C@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF2D02D7FE.D57DABBB-ONC1256E66.0036A8C5-C1256E66.00373A2C@de.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 12:03:13PM +0200, Martin Schwidefsky wrote:
> 
> Did I manage to convince you or are you just fed up with the discussion?

Heh, I'm still not convinced :)

> I'll ask because the zfcp patches are still pending and I want to get this
> issue resolved before the next try to get them integrated.

I think you need to talk to the scsi people, as kfree() should _never_
need to be set as the release function.  There's something just wrong
with the design if that is necessary.

thanks,

greg k-h

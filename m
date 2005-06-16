Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVFPSe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVFPSe7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 14:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVFPSe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 14:34:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:60382 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261752AbVFPSer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 14:34:47 -0400
Date: Thu, 16 Jun 2005 11:34:12 -0700
From: Greg KH <greg@kroah.com>
To: Hareesh Nagarajan <hareesh@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Porting kref to a 2.4 kernel (2.4.20 or greater)
Message-ID: <20050616183412.GB11378@kroah.com>
References: <42B06344.4040909@google.com> <20050615220734.GC620@kroah.com> <42B0B017.60001@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B0B017.60001@google.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 03:47:51PM -0700, Hareesh Nagarajan wrote:
> Correction:
> (Appears with a *)
> 
> Greg KH wrote:
> >On Wed, Jun 15, 2005 at 10:20:04AM -0700, Hareesh Nagarajan wrote:
> >
> >>What stumbling blocks do you think I would encounter if I wanted to port 
> >>kref to a 2.4.xx kernel? Is kref tightly coupled with the kernel object 
> >>infrastructure found in the 2.6.xx kernel?
> >
> >Have you looked at the kref code to see if there is any such coupling?
> 
> Not really. Kref seems pretty light and loosely coupled with the 2.6
> kernel. There just appears to be a C file (and a .h of course).

Exactly, that code should have no problems working in 2.4.

Good luck,

greg k-h

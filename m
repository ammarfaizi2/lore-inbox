Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVFOWM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVFOWM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVFOWKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:10:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:58855 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261614AbVFOWI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:08:59 -0400
Date: Wed, 15 Jun 2005 15:07:34 -0700
From: Greg KH <greg@kroah.com>
To: Hareesh Nagarajan <hareesh@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Porting kref to a 2.4 kernel (2.4.20 or greater)
Message-ID: <20050615220734.GC620@kroah.com>
References: <42B06344.4040909@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B06344.4040909@google.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 10:20:04AM -0700, Hareesh Nagarajan wrote:
> Hi,
> 
> What stumbling blocks do you think I would encounter if I wanted to port 
> kref to a 2.4.xx kernel? Is kref tightly coupled with the kernel object 
> infrastructure found in the 2.6.xx kernel?

Have you looked at the kref code to see if there is any such coupling?
Can you describe any problems you are having doing the uncoupling?

What do you want this in the 2.4 kernel for?  You know that no new
features are being accepted for that tree, right?

thanks,

greg k-h

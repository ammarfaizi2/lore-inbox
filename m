Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbULOAsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbULOAsf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbULOAsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:48:23 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:734 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261791AbULOAq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:46:28 -0500
Date: Tue, 14 Dec 2004 16:46:20 -0800
From: Greg KH <greg@kroah.com>
To: Al Hooton <al@hootons.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ioctl assignment strategy?
Message-ID: <20041215004620.GA15850@kroah.com>
References: <1103067067.2826.92.camel@chatsworth.hootons.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103067067.2826.92.camel@chatsworth.hootons.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 03:31:07PM -0800, Al Hooton wrote:
> 	It was 6-7 years ago that I last worked on driver level stuff, I expect
> I've got a whack with a cluebat coming....

Minor one coming, why do you want to use an ioctl?  ioctls are generally
frowned upon these days, and trying to add a new one is a tough and
arduous process, that is not for the weak, or faint of heart.

thanks,

greg k-h

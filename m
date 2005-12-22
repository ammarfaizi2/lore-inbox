Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbVLVSbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbVLVSbE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbVLVSac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:30:32 -0500
Received: from [206.124.142.26] ([206.124.142.26]:15064 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S1030260AbVLVSaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:30:22 -0500
Date: Thu, 22 Dec 2005 10:30:12 -0800
From: Marc Singer <elf@buici.com>
To: Axel Kittenberger <axel.kittenberger@univie.ac.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible Bootloader Optimization in inflate (get rid of unnecessary 32k Window)
Message-ID: <20051222183012.GA27353@buici.com>
References: <200512221352.23393.axel.kernel@kittenberger.net> <20051222173704.GB23411@buici.com> <1167.81.217.14.229.1135275158.squirrel@webmail.univie.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167.81.217.14.229.1135275158.squirrel@webmail.univie.ac.at>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 07:12:38PM +0100, Axel Kittenberger wrote:
> > Have you timed this operation?  I would predict that the time to copy
> > the kernel is nominal as compared the the time taken to perform the
> > decompression.
> 
> In the current version it is defleated AND copied. The optimization would
> reduce it by 1 copy.

Right.  And the time to perform that one copy is exactly...?

I doubt that it is a significant percentage of the whole operation.

> 
> Greetings, Axel

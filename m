Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbTKTVum (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 16:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbTKTVum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 16:50:42 -0500
Received: from gaia.cela.pl ([213.134.162.11]:37900 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S263081AbTKTVuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 16:50:40 -0500
Date: Thu, 20 Nov 2003 22:49:53 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Timothy Miller <miller@techsource.com>
cc: Andreas Dilger <adilger@clusterfs.com>,
       Justin Cormack <justin@street-vision.com>,
       Jesse Pollard <jesse@cats-chateau.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
In-Reply-To: <3FBD328C.1070607@techsource.com>
Message-ID: <Pine.LNX.4.44.0311202249150.10515-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is, though.  If you run out of space copying a file, you know it when 
> you're copying.  Applications don't usually expect to get out-of-space 
> errors while overwriting something in the middle of a file.

What about sparse files?

> In effect, your free space and your used space add up to greater than 
> the capacity of the disk.  An application that checks for free space 
> before doing something would be fooled into thinking there is more free 
> space than there really is.  How can an application find out in advance 
> that a file that it's about to modify (without appending anything to the 
> end) is going to need more disk space?

I don't think it can do that already now with sparse files, can it?

Cheers,
MaZe.



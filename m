Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbULaSB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbULaSB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 13:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbULaSB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 13:01:58 -0500
Received: from dialin-163-34.tor.primus.ca ([216.254.163.34]:11648 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S262128AbULaSB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 13:01:56 -0500
Date: Fri, 31 Dec 2004 13:01:51 -0500
From: William Park <opengeometry@yahoo.ca>
To: Simon Burke <simon.burke@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /tmp as ramdisk
Message-ID: <20041231180151.GA2975@node1.opengeometry.net>
Mail-Followup-To: Simon Burke <simon.burke@gmail.com>,
	linux-kernel@vger.kernel.org
References: <2d7d2dd20412310941724cc1cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d7d2dd20412310941724cc1cb@mail.gmail.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2004 at 05:41:43PM +0000, Simon Burke wrote:
> Stupid question really.
> 
> On my servers I'd like to mount /tmp as a ramdisk, for several
> reasons. How would i go about this with linux? Is it as simple as
> putting it in the /etc/fstab?  where do i define the size of such a
> disk?

mount -t tmpfs tmpfs /tmp

-- 
William Park <opengeometry@yahoo.ca>
Open Geometry Consulting, Toronto, Canada
Linux solution for data processing. 

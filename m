Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbTIXMj7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 08:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTIXMj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 08:39:59 -0400
Received: from cpc1-cwma1-5-0-cust4.swan.cable.ntl.com ([80.5.120.4]:24527
	"EHLO dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261304AbTIXMj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 08:39:58 -0400
Subject: Re: How are the Promise drivers doing?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m3he33c6x9.fsf@averell.firstfloor.org>
References: <yX7w.79l.13@gated-at.bofh.it>
	 <m3he33c6x9.fsf@averell.firstfloor.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064407092.13450.10.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Wed, 24 Sep 2003 13:38:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-24 at 02:27, Andi Kleen wrote:
> One big problem with the Promise drivers is that they are not 64bit
> clean. Trying them in a 64bit x86-64 kernel fails quickly.
> Fixing them is unfortunately a lot of work because of the weird
> Windows like programming style in the CAM layer in there.
> 
> Also at least some released versions of them had gapping security holes
> in the ioctl handlers.

Looking at the BSD drivers you may well be able to do a minimal mmio
version of the 2026x driver for the chips as a stopgap. That wouldn't be
as good as the full libata thing once it is done but it would make it go


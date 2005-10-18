Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVJROOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVJROOV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 10:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVJROOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 10:14:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47239 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750762AbVJROOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 10:14:20 -0400
Date: Wed, 19 Oct 2005 00:12:18 +1000
From: Nathan Scott <nathans@sgi.com>
To: Roushan Ali <roushan.ali@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file system block size
Message-ID: <20051019001218.B5830881@wobbly.melbourne.sgi.com>
References: <30b4e63b0510172252x1dfca9f2l75bb0f183aecf7bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <30b4e63b0510172252x1dfca9f2l75bb0f183aecf7bb@mail.gmail.com>; from roushan.ali@gmail.com on Tue, Oct 18, 2005 at 11:22:27AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 11:22:27AM +0530, Roushan Ali wrote:
> Hi All,
>          we want to write a new file system with block size more than
> 4KB. Can anyone suggest us how should we proceed ?

With great difficulty. ;)

There is really no support for this in the generic page cache
code in the kernel, and you'd probably need some mechanism for
doing multi-page metadata IOs.  There's been sporadic discussion
on fs-devel and linux-xfs in the past on this topic - you could
search those archives for details.

cheers.

-- 
Nathan

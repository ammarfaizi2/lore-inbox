Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUFXD2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUFXD2c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 23:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUFXD2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 23:28:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:32439 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263761AbUFXD2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 23:28:30 -0400
Date: Wed, 23 Jun 2004 20:28:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: slow performance w/patch-2.6.7-mjb1
Message-ID: <1952580000.1088047703@[10.10.2.4]>
In-Reply-To: <20040624004429.76093.qmail@web51806.mail.yahoo.com>
References: <20040624004429.76093.qmail@web51806.mail.yahoo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is a litle bit more information:
> 2.6.7-mjb1 w/4G split enabled:
> 44.91user 56.95system 1:46.30elapsed 95%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+6907875minor)pagefaults
> 0swaps
> 
> 
> 2.6.7-mjb1 w/4G disabled enabled:
> 30.71user 34.56system 1:11.29elapsed 91%CPU
> (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (21major+6907525minor)pagefaults
> 0swaps
> 
> Clearly something is wrong.  This is making headers
> which does a lot of spawning of bash shells and ln -s
> different files and some minor dependancy makes.
> 
> Any help understanding what is happending here would
> be greatly appreciated!

Mmmm. Try grabbing a kernel profile of both, and it might
be easier to see what the overhead is, exactly. See 
Documentation/basic_profiling.txt for instructions if you haven't
done it before.

M.


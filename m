Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264320AbUANUu7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 15:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbUANUu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 15:50:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:50603 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264320AbUANUuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 15:50:54 -0500
Date: Wed, 14 Jan 2004 12:52:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jim Faulkner <jfaulkne@ccs.neu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
Message-Id: <20040114125210.1dc50593.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.58.0401141357410.10111@denali.ccs.neu.edu>
References: <Pine.GSO.4.58.0401141357410.10111@denali.ccs.neu.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Faulkner <jfaulkne@ccs.neu.edu> wrote:
>
> I am experiencing data corruption on my AES cryptoloop partition under
> recent -mm kernels (including 2.6.1-mm3).  I am unsure how long this
> problem has existed, and I am unsure if this problem exists in the
> mainstream kernel (I can't test it because of an aic7xxx bug in the
> mainstream kernel).

It exists in the mainstream kernel.

I thought we had this whipped in 2.6.0-mm2, but then I removed the loop
patches and switched to a new set.  I think I'll switch back.

It would be interesting to find out if 2.6.0-mm2 is working OK for you.

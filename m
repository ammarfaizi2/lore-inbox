Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVCRE6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVCRE6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 23:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVCRE6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 23:58:16 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:63981 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S261466AbVCRE6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 23:58:14 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: 32Bit vs 64Bit
To: regatta <regatta@gmail.com>, Eric Dumazet <dada1@cosmosbay.com>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 18 Mar 2005 06:02:09 +0100
References: <fa.d8o1hmd.1l3ipbn@ifi.uio.no> <fa.jg14340.1g0go0q@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DC9cf-0006Ji-BT@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

regatta <regatta@gmail.com> wrote:

> My question because We ran a 32 Bit application in Sun AMD64 Optreon
> with 1GB connection (Kernel 2.4 x86_64 with 8 Gb memory & 2 CPUs)  and
> we had trouble time with it because the user tried to put the
> application processing data in a nas box (in the network) and that
> made the machine to use more than 60% of the NAS CPU and no one else
> was able to access the NAS

Does the application happen to frequently access the data in small chunks
randomly scatterd across the file(s)?


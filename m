Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264669AbTD0O3o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 10:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264675AbTD0O3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 10:29:44 -0400
Received: from franka.aracnet.com ([216.99.193.44]:4070 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264669AbTD0O3n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 10:29:43 -0400
Date: Sun, 27 Apr 2003 07:41:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Houston, I think we have a problem
Message-ID: <28750000.1051454510@[10.10.2.4]>
In-Reply-To: <5.2.0.9.2.20030427090009.01f89870@pop.gmx.net>
References: <5.2.0.9.2.20030427090009.01f89870@pop.gmx.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To reproduce this 100% of the time, simply compile virgin 2.5.68
> up/preempt, reduce your ram to 128mb, and using gcc-2.95.3 as to not
> overload the vm, run a make -j30 bzImage in an ext3 partition on a P3/500
> single ide disk box.  No, you don't really need to meet all of those
> restrictions... you'll see the problem on a big hairy chested box as
> well, just not as bad as I see it on my little box.  The first symptom of
> the problem you will notice is a complete lack of swap activity along
> with highly improbable quantities of unused ram were all those hungry
> cc1's getting regular CPU feedings.

Yes, that's why I don't use ext3 ;-) It's known broken, akpm is fixing it.

M.


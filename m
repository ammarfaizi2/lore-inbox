Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262480AbSJKOqo>; Fri, 11 Oct 2002 10:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262486AbSJKOqo>; Fri, 11 Oct 2002 10:46:44 -0400
Received: from franka.aracnet.com ([216.99.193.44]:26789 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262480AbSJKOqn>; Fri, 11 Oct 2002 10:46:43 -0400
Date: Fri, 11 Oct 2002 07:47:30 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Andrew Theurer <habanero@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pooling NUMA scheduler with initial load balancing
Message-ID: <1711018324.1034322449@[10.10.2.3]>
In-Reply-To: <200210111027.59589.efocht@ess.nec.de>
References: <200210111027.59589.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, I thought the smp_tune_scheduling() call went lost during the
> transition to the new cpu boot scheme. But it's there. And the problem
> is indeed "notsc". So you'll have to fix it, I can't.

Errrm ... not sure what you mean by this. notsc is a perfectly
valid thing to do, so if your patch panics with that option, I 
suggest you make something conditional on notsc inside your patch?
Works just fine without your patch, or with Michael's patch ....

M.


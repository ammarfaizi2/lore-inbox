Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbSKFHOO>; Wed, 6 Nov 2002 02:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265668AbSKFHOO>; Wed, 6 Nov 2002 02:14:14 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:39675 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265667AbSKFHOO>;
	Wed, 6 Nov 2002 02:14:14 -0500
Message-Id: <200211060720.gA67K0D17250@eng4.beaverton.ibm.com>
To: Lev Makhlis <mlev@despammed.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] 2.5.46: overflow in disk stats 
In-reply-to: Your message of "Wed, 06 Nov 2002 00:09:51 EST."
             <200211060009.51684.mlev@despammed.com> 
Date: Tue, 05 Nov 2002 23:19:59 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I see that the SARD changes have been merged, but MSEC() still has
    the overflow problem.  This takes care of it:

Thanks.  These patches left my control late in the game and have a couple
of other problems with them too. Watch for at least one more patch to
remove the old statistics counters as well. Inexplicably, we are now
counting statistics twice.

Rick

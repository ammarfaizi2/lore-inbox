Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289120AbSAJCQq>; Wed, 9 Jan 2002 21:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289121AbSAJCQg>; Wed, 9 Jan 2002 21:16:36 -0500
Received: from nile.gnat.com ([205.232.38.5]:14740 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S289120AbSAJCQZ>;
	Wed, 9 Jan 2002 21:16:25 -0500
From: dewar@gnat.com
To: fjh@cs.mu.OZ.AU, pbarada@mail.wm.sps.mot.com
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Message-Id: <20020110021624.21D50F3147@nile.gnat.com>
Date: Wed,  9 Jan 2002 21:16:24 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<< |        [#5] The least requirements on a  conforming  implementation
 |        are:
 |
 |          -- At  sequence points, volatile objects are stable in the
 |             sense  that  previous   accesses   are   complete   and
 |             subsequent accesses have not yet occurred.
>>

Note that this particular requirement is much laxer than that in the 
Ada standard, since it is specialized to sequence points, and would
appear to allow reordering of accesses between sequence points)

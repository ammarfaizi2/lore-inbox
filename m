Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132802AbRDDL5K>; Wed, 4 Apr 2001 07:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132805AbRDDL5B>; Wed, 4 Apr 2001 07:57:01 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:47045 "HELO mail.inf.elte.hu")
	by vger.kernel.org with SMTP id <S132802AbRDDL4r>;
	Wed, 4 Apr 2001 07:56:47 -0400
Date: Wed, 4 Apr 2001 13:56:05 +0200
From: GOMBAS Gabor <gombasg@inf.elte.hu>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: /proc/config idea
Message-ID: <20010404135604.A192662@pandora.inf.elte.hu>
In-Reply-To: <3AC91800.22D66B24@mandrakesoft.com> <Pine.LNX.4.33.0104021734400.30128-100000@dlang.diginsite.com> <20010403161322.A8174@werewolf.able.es> <3ACA1A91.70401@kalifornia.com> <20010403211218.A2387@werewolf.able.es> <20010403123014.A17132@thune.yy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010403123014.A17132@thune.yy.com>; from dalgoda@ix.netcom.com on Tue, Apr 03, 2001 at 12:30:14PM -0700
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2001 at 12:30:14PM -0700, Mike Castle wrote:

> Some patches, such as the RAID patches, sets up EXTRAVERSION to a specific
> value.

- If you apply such a patch first, and after that you edit EXTRAVERSION,
your value will be used - no problem.

- If you edit EXTRAVERSION before applying such a patch, the specific hunk
trying to change the EXTRAVERSION will be rejected - again no problem.
Actually this is already the case when you apply 2 patches trying to set
EXTRAVERSION to 2 different values...

> I do with the make file also had a USERVERSION that would be hands off for
> anyone but the builder.

It is not needed.

Gabor

-- 
Gabor Gombas                                       Eotvos Lorand University
E-mail: gombasg@inf.elte.hu                        Hungary

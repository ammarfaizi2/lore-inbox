Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316477AbSGGTM5>; Sun, 7 Jul 2002 15:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSGGTM4>; Sun, 7 Jul 2002 15:12:56 -0400
Received: from dsl-65-188-251-69.telocity.com ([65.188.251.69]:62927 "EHLO
	orr.homenet") by vger.kernel.org with ESMTP id <S316477AbSGGTMz>;
	Sun, 7 Jul 2002 15:12:55 -0400
Date: Sun, 7 Jul 2002 15:15:17 -0400
From: Jason Lunz <lunz@gtf.org>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NAPI patch against 2.4.18
Message-ID: <20020707191517.GA14331@orr.falooley.org>
References: <3D287DA4.5090904@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D287DA4.5090904@candelatech.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


greearb@candelatech.com said:
> Does anyone have a working NAPI kernel and tulip driver patch against
> 2.4.18 or so?  I will be happy to test this if so.

Yes, I backported the core last week to 2.4.19-rc1 from 2.5.24, but the
patch ought to apply to 2.4.18 with only offset mismatches. I kept a lot
of style cleanups in the patch, but they should be easy to remove if
they cause problems. I'll be backporting the various napified drivers to
2.4 this week.

http://orr.falooley.org/pub/linux/net/

Jason

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268909AbRHDPmp>; Sat, 4 Aug 2001 11:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268913AbRHDPmf>; Sat, 4 Aug 2001 11:42:35 -0400
Received: from weta.f00f.org ([203.167.249.89]:18320 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S268909AbRHDPmX>;
	Sat, 4 Aug 2001 11:42:23 -0400
Date: Sun, 5 Aug 2001 03:43:12 +1200
From: Chris Wedgwood <cw@f00f.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: /proc/<n>/maps getting _VERY_ long
Message-ID: <20010805034312.A18996@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some time ago, the logic for merging VMAs was changing (simplified).
I noticed a couple of applications, specifically things seemed a bit
sluggish when running things that either grow slowly or use lots of
shared libraries:

cw:tty5@tapu(cw)$ wc -l /proc/1368/maps
   5287 /proc/1368/maps

it's totally unusual.

Can anyone tell me why we don't merge such entries anymore?




  --cw




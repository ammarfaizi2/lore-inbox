Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318091AbSGMEkN>; Sat, 13 Jul 2002 00:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318092AbSGMEkM>; Sat, 13 Jul 2002 00:40:12 -0400
Received: from dsl-213-023-043-071.arcor-ip.net ([213.23.43.71]:48109 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318091AbSGMEkL>;
	Sat, 13 Jul 2002 00:40:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Dax Kelson <dax@gurulabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Date: Sat, 13 Jul 2002 06:44:22 +0200
X-Mailer: KMail [version 1.3.2]
References: <1026490866.5316.41.camel@thud>
In-Reply-To: <1026490866.5316.41.camel@thud>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17TElb-0002jB-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 July 2002 18:21, Dax Kelson wrote:
> Any suggestions or comments appreciated.

"it is clear that IF your server is stable and not prone to crashing, and/or 
you have the write cache on your hard drives battery backed, you should 
strongly consider using the writeback journaling mode of Ext3 versus ordered."

You probably want to suggest UPS there rather than battery backed disk
cache, since the writeback caching is predominantly on the cpu side.

-- 
Daniel

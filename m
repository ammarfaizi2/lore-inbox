Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263009AbTCSL1T>; Wed, 19 Mar 2003 06:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263010AbTCSL1T>; Wed, 19 Mar 2003 06:27:19 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:61333 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S263009AbTCSL1S>; Wed, 19 Mar 2003 06:27:18 -0500
Date: Wed, 19 Mar 2003 22:37:56 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, akpm@zip.com.au, adilger@clusterfs.com
Subject: 2.5.65: ext3 journal recover slow and hangs
Message-ID: <20030319113752.GA505@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed something as my system was recovering from constant crashes
under 2.5.65. The journal recovery for my partitions is very, very slow
with nary a HD write during the recover. On one partition the system
hung twice. There was no message or anything. The cursor just turned off
and no typing, alt+sysrq or ctrl+alt+del would register.

I am currently running under 2.5.64 and the journal recovery went as
normal.

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, 'President' of Regime of the United States
          September 26, 2002 (from a political fundraiser in Houston, Texas)

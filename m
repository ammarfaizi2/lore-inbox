Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317036AbSHBUqx>; Fri, 2 Aug 2002 16:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317059AbSHBUqx>; Fri, 2 Aug 2002 16:46:53 -0400
Received: from inmail.compaq.com ([161.114.1.205]:9231 "EHLO
	ztxmail01.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S317036AbSHBUqu>; Fri, 2 Aug 2002 16:46:50 -0400
Date: Fri, 2 Aug 2002 15:47:51 -0500
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.30 breaks cciss driver?
Message-ID: <20020802154751.A1943@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just saw this problem with 2.5.30.

I can't mount my 2nd volume on a cciss controller (SmartArray 5i)

< /dev/cciss/c0d1p1 /u1
No such device or address

The first volume, /dev/cciss/c0d0p1, works fine
(I'm booted from it.)

Reboot 2.5.29, both volumes work fine.

I don't have time to look into this right now,
but I thought I'd mention it in case someone else
does have time.  Looks like there was some partition 
code and/or devfs changes...

-- steve

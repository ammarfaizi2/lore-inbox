Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266316AbSKOOLL>; Fri, 15 Nov 2002 09:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266318AbSKOOLK>; Fri, 15 Nov 2002 09:11:10 -0500
Received: from smtprelay6.dc2.adelphia.net ([64.8.50.38]:62673 "EHLO
	smtprelay6.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S266316AbSKOOLK>; Fri, 15 Nov 2002 09:11:10 -0500
From: Tony Likhite <tony@likhite.net>
To: balihb@cracker.hu, linux-kernel@vger.kernel.org
Subject: Re: comp bug in 2.4.20-rc1-ac2???
Date: Fri, 15 Nov 2002 09:19:07 -0500
User-Agent: KMail/1.4.7
References: <E18Cgv6-0004lA-00@armada.prim.hu>
In-Reply-To: <E18Cgv6-0004lA-00@armada.prim.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211150919.08021.tony@likhite.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 November 2002 08:54, balihb@cracker.hu wrote:
> Bug in 2.4.20-rc1-ac2???

I get the same thing in -ac3.  I think mm/rmap.c should #include 
<linux/smp_lock.h> instead of <asm/smplock.h>

Tony


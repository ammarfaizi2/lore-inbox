Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUG0BRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUG0BRG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 21:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbUG0BN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 21:13:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:40151 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266234AbUG0BLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 21:11:46 -0400
Date: Mon, 26 Jul 2004 18:09:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: kernel@kolivas.org, Joel.Becker@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
Message-Id: <20040726180943.4c871e4f.akpm@osdl.org>
In-Reply-To: <4105A761.9090905@tequila.co.jp>
References: <cone.1090801520.852584.20693.502@pc.kolivas.org>
	<20040725173652.274dcac6.akpm@osdl.org>
	<cone.1090802581.972906.20693.502@pc.kolivas.org>
	<20040726202946.GD26075@ca-server1.us.oracle.com>
	<20040726134258.37531648.akpm@osdl.org>
	<cone.1090882721.156452.20693.502@pc.kolivas.org>
	<4105A761.9090905@tequila.co.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer <cs@tequila.co.jp> wrote:
>
> Con Kolivas wrote:
> | Andrew Morton writes:
> 
> |> Yes, I think 60% is about right for a 512-768M box.  Too high for the
> |> smaller machines, too low for the larger ones.
> |
> |
> | Sigh..
> | I have a 1Gb desktop machine that refuses to keep my applications in ram
> | overnight if I have a swappiness higher than the default so I think lots
> | of desktop users with more ram will be unhappy with higher settings.
> 
> I have 1 GB and I had a setting of 51 (seemed to be perhaps gentoo
> default or so) and I especially after a weekend (2 days off) it is
> always the "monday-morning-swap-hell" where I have to wait 5min until he
> swapped in the apps he swapped out during weekend.
> 
> I changed that to 20 now, but I don't know if this will make things
> worse or better.
> 

It may appear to be better, but you now have 100, maybe 200 megabytes less
pagecache available across the entire working day.


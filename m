Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261822AbTCGWZT>; Fri, 7 Mar 2003 17:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261821AbTCGWZT>; Fri, 7 Mar 2003 17:25:19 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:59793 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S261822AbTCGWZT>; Fri, 7 Mar 2003 17:25:19 -0500
Date: Fri, 7 Mar 2003 17:35:46 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Anders Widman <andewid@tnonline.net>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Entire LAN goes boo with 2.5.64
In-Reply-To: <17913565781.20030307221016@tnonline.net>
Message-ID: <Pine.GSO.4.33.0303071732490.4835-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003, Anders Widman wrote:
>Yes,  you might be right. WinRoute is running as DCHP for the network,
>and  the  problems  do  start as soon as Linux tries to lease an IP...
>hm..

If you are using DHCP, it is critical that every machine have a correctly
set clock (see also: xntpd)  Otherwise, the client may see the lease expire
before it requested it. (what happens in such a case varies with the software
and version.)

--Ricky



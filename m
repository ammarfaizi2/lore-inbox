Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318947AbSHSROv>; Mon, 19 Aug 2002 13:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318949AbSHSROv>; Mon, 19 Aug 2002 13:14:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21777 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318947AbSHSROv>; Mon, 19 Aug 2002 13:14:51 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Kernel.Org bug in viewing of patches
Date: 19 Aug 2002 10:18:37 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ajr99d$ija$1@cesium.transmeta.com>
References: <3D60842D.7030406@genebrew.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3D60842D.7030406@genebrew.com>
By author:    Rahul Karnik <rahul@genebrew.com>
In newsgroup: linux.dev.kernel
>
> Kernel.Org admins,
> 
> I was using the nifty patch viewing feature on the homepage when I 
> noticed that in the per-file patch list for a given patch, the links 
> generated are not correct. An example is the current ac patch view at:
> 
> http://www.kernel.org/diff/diffview.cgi?file=/pub/linux/kernel/people/alan/linux-2.4/2.4.20/patch-2.4.20-pre2-ac4.gz
> 
> Clicking on the link for drivers/net/3c59x.c actually leads to the patch 
> for drivers/net/cs89x0.h. Similar problems appear to exist for viewing 
> of the other patches as well, with different offsets in the file list.
> 

The problem seems to be with diffstat, which occationally drops hunks
-- resulting in the count being incorrect.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

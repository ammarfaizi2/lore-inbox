Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292121AbSBOVGK>; Fri, 15 Feb 2002 16:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292122AbSBOVGB>; Fri, 15 Feb 2002 16:06:01 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:32914 "EHLO
	postfix2-1.free.fr") by vger.kernel.org with ESMTP
	id <S292121AbSBOVFq>; Fri, 15 Feb 2002 16:05:46 -0500
From: Willy Tarreau <wtarreau@free.fr>
Message-Id: <200202152105.g1FL5a200782@ns.home.local>
Subject: Re: [SUCCESS] Linux 2.4.18-rc1
To: romieu@cogenit.fr
Date: Fri, 15 Feb 2002 22:05:36 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Willy TARREAU <tarreau@aemiaif.lip6.fr> :
> [...]
> > I also slightly patched procfs to allow comx to link. It requires
> > proc_get_inode() which was not exported (that's what my patch does),
>
> Please don't do that. comx should to be fixed. Question was raised on l-k 
> some months ago.
> 
> -- 
> Ueimor

Anyway, that's what I was feeling because when only one driver uses
a procfs feature, it smells really bad. I just wanted to try to compile
everything to check what needed fixing and what could be done quickly.

Regards,
Willy

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267383AbTBFU7W>; Thu, 6 Feb 2003 15:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267388AbTBFU7W>; Thu, 6 Feb 2003 15:59:22 -0500
Received: from franka.aracnet.com ([216.99.193.44]:3252 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267383AbTBFU7V>; Thu, 6 Feb 2003 15:59:21 -0500
Date: Thu, 06 Feb 2003 13:08:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: niteowl@intrinsity.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 kernel bugs
Message-ID: <267250000.1044565727@[10.10.2.4]>
In-Reply-To: <200302062043.h16KhHY05212@bletchley.vert.intrinsity.com>
References: <200302062043.h16KhHY05212@bletchley.vert.intrinsity.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> FWIW, here's a list of potential 2.5.59 kernel bugs.  Some of these
> might be causing real trouble. Many are probably benign.  A few may be
> non-bugs that are just poor coding style although I've tried to weed
> most of those out of this list.  
> 
> The fs/super.c bug is probably the most serious of the bunch as it appears
> to completely disable the sync_filesystems() function.

Some fairly sickening stuff ... I'll log the following sections in bugzilla
If any brave volunteers for the others want to go ahead with the other
sections, and split the effort, would be much appreciated. Please mail
back to lkml that you're doing it ... and watch very carefully on newly
logged bugs for collisions ;-)
 
> ===== dangling else =====
> ===== misplaced/extra semicolon =====
> =====  double logical operator =====


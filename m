Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSHDSEs>; Sun, 4 Aug 2002 14:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318164AbSHDSEs>; Sun, 4 Aug 2002 14:04:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1799 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315806AbSHDSEr>; Sun, 4 Aug 2002 14:04:47 -0400
Date: Sun, 4 Aug 2002 19:08:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Small problem with pmd_page in 2.5
Message-ID: <20020804190819.B2995@flint.arm.linux.org.uk>
References: <20020804125730.A1113@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020804125730.A1113@devserv.devel.redhat.com>; from zaitcev@redhat.com on Sun, Aug 04, 2002 at 12:57:30PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2002 at 12:57:30PM -0400, Pete Zaitcev wrote:
> I was looking a little bit at sparc(32) and ran into a difficulty
> with pmd_page. The 2.5 version returns struct page*, presumably
> to support page tables in highmem. Unfortunately, sparc (sun4m
> actually) cannot do that, because its page tables are smaller
> than memory pages.

Same problem as ARM.  For a description of how we fixed it, please
see:

http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2002-March/008089.html

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


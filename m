Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbTB0Unq>; Thu, 27 Feb 2003 15:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbTB0Unq>; Thu, 27 Feb 2003 15:43:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61327 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266886AbTB0Unq>;
	Thu, 27 Feb 2003 15:43:46 -0500
Date: Thu, 27 Feb 2003 12:37:01 -0800 (PST)
Message-Id: <20030227.123701.16257819.davem@redhat.com>
To: bcollins@debian.org
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       ak@suse.de, arnd@bergmann-dalldorf.de
Subject: Re: ioctl32 consolidation -- call for testing
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030227205044.GQ21100@phunnypharm.org>
References: <20030227203440.GP21100@phunnypharm.org>
	<20030227.122126.30208201.davem@redhat.com>
	<20030227205044.GQ21100@phunnypharm.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Collins <bcollins@debian.org>
   Date: Thu, 27 Feb 2003 15:50:44 -0500

   On Thu, Feb 27, 2003 at 12:21:26PM -0800, David S. Miller wrote:
   > Well, you just doubled the size of the table on sparc64.
   > I don't know if I like that.
   
   Not much of a way around it.

Such problems are only in your mind. :-)

What's wrong with defining the type and accessor macros
in include/asm/compat.h?

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317342AbSGXPWk>; Wed, 24 Jul 2002 11:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317347AbSGXPWk>; Wed, 24 Jul 2002 11:22:40 -0400
Received: from dsl-65-188-226-101.telocity.com ([65.188.226.101]:4788 "EHLO
	crown.reflexsecurity.com") by vger.kernel.org with ESMTP
	id <S317342AbSGXPWk>; Wed, 24 Jul 2002 11:22:40 -0400
Date: Wed, 24 Jul 2002 11:25:48 -0400
From: Jason Lunz <lunz@reflexsecurity.com>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DFE-580TX problems you posted on 05-24-02
Message-ID: <20020724152548.GA3967@reflexsecurity.com>
References: <20020723203037.GA29459@pobox.com> <3D3DCD2C.1050004@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3DCD2C.1050004@candelatech.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In gmane.linux.kernel, you wrote:
> The fix for the DFE-580tx in Linux is to either download the driver
> from dlink's site (I don't have the exact URL, but you can find it if
> you look.), or perhaps use Becker's latest driver from www.scyld.com.

That's not the whole story.

All the drivers I've tried will work if compiled with USE_IO_OPS
defined, but will behave badly under load. That is, when heavily loaded
they will lock up and reset after a several-second timeout expires. This
is true for Becker's 1.09 driver, the latest in-kernel driver, and
Edward Peng's napi sundance driver. (With the exception that the napi
driver doesn't recover after it locks up). Peng's driver is at
http://edward_peng.tripod.com/, and his email address from the dl2k
driver indicates that he works for Dlink.

I looked on dlink's web and ftp sites, but was unable to find any linux
driver for the DFE-580TX. How did you find it?

-- 
Jason Lunz			Reflex Security
lunz@reflexsecurity.com		http://www.reflexsecurity.com/

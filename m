Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264389AbTCYXx6>; Tue, 25 Mar 2003 18:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264406AbTCYXx6>; Tue, 25 Mar 2003 18:53:58 -0500
Received: from CPE-144-132-194-153.nsw.bigpond.net.au ([144.132.194.153]:42882
	"EHLO anakin.wychk.org") by vger.kernel.org with ESMTP
	id <S264389AbTCYXx4>; Tue, 25 Mar 2003 18:53:56 -0500
Date: Wed, 26 Mar 2003 07:55:30 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: linux-kernel@vger.kernel.org, pleb@cse.unsw.edu.au
Cc: linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [Patch] [arm] support older plebs
Message-ID: <20030325235530.GA4438@anakin.wychk.org>
References: <20030325161358.GA30538@anakin.wychk.org> <20030325163843.D24418@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Disposition: inline
In-Reply-To: <20030325163843.D24418@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc-ing to linux-arm-kernel ]

On Tue, Mar 25, 2003 at 04:38:43PM +0000, Russell King wrote:
> On Wed, Mar 26, 2003 at 12:13:58AM +0800, Geoffrey Lee wrote:
> > The PLEB is a SA-1100-based ARM computer developed at CSE at the
> > University of New South Wales.  I have discovered some of the earlier
> > models would not set register 1 properly, which was required for Linux
> > to boot.  This was inside their (very old) kernel tree but which they 
> > never submitted for inclusion (?)  It is a Photon1 with catapult
> > bootloader combination.
> 
> I've been killing these - people should really be passing the right
> value of r1 to the kernel.  Think what happens when 200 different
> machine types add these 3 lines.
> 

I totally agree that it is wrong not to set r1.


Thank goodness that in 2.4.x not many arm boards need this hack :)

Anyway, inside the (very old) pleb kernel tree, it was marked as a "hack".  

> A saner solution would be to define this appropriately if we're only
> being built for one platform.
> 

Yes.  That sounds good.


	-- G.
-- 
char p[] = "\xeb\x1f\x5e\x89\x76\x08\x31\xc0\x88\x46\x07\x89\x46\x0c\xb0\x0b"
  "\x89\xf3\x8d\x4e\x08\x8d\x56\x0c\xcd\x80\x31\xdb\x89\xd8\x40\xcd"
  "\x80\xe8\xdc\xff\xff\xff/bin/sh";



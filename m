Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289918AbSBFBjz>; Tue, 5 Feb 2002 20:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289972AbSBFBjp>; Tue, 5 Feb 2002 20:39:45 -0500
Received: from ns.suse.de ([213.95.15.193]:4875 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289954AbSBFBjj>;
	Tue, 5 Feb 2002 20:39:39 -0500
Date: Wed, 6 Feb 2002 02:39:37 +0100
From: Dave Jones <davej@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Warning, 2.5.3 eats filesystems
Message-ID: <20020206023937.G25441@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020205192826.GA112@elf.ucw.cz> <878za7wmg0.fsf@inanna.rimspace.net> <20020206010219.YXFM10804.out006.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020206010219.YXFM10804.out006.verizon.net@pool-141-150-235-204.delv.east.verizon.net>; from skip.ford@verizon.net on Tue, Feb 05, 2002 at 07:59:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2002 at 07:59:57PM -0500, Skip Ford wrote:
 > I can confirm inode errors also.  However, I can't be sure it's 2.5.3 that
 > did it.

 Recall that pre3/pre4/pre5 had the missing ext2_inode_info initialisation bug.
 If you booted any of those, and have only just done a fsck, it could
 be a leftover artifact of a now-fixed bug.

 > All of the errors I've had all seemed to be files included in the
 > pre-patch that broke Configure.help into pieces.  I don't know the code
 > well enough, but if the errors could only have happened at file creation
 > then that would rule out 2.5.3.

 Indeed, that change was in pre5, which was the last pre to feature
 aforementioned buglet.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

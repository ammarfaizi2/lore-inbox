Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271757AbRHRBDR>; Fri, 17 Aug 2001 21:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271758AbRHRBDH>; Fri, 17 Aug 2001 21:03:07 -0400
Received: from mercury.is.co.za ([196.4.160.222]:54788 "HELO mercury.is.co.za")
	by vger.kernel.org with SMTP id <S271757AbRHRBC6>;
	Fri, 17 Aug 2001 21:02:58 -0400
Date: Sat, 18 Aug 2001 03:03:21 +0200
From: Dewet Diener <linux-kernel@dewet.org>
To: linux-kernel@vger.kernel.org
Subject: ext3 partition unmountable
Message-ID: <20010818030321.A11649@darkwing.flatlit.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

After umounting a removable ext3 partition from my work PC, and 
trying to remount it at home, I've run into the following error
trying to mount it as both ext2 and ext3:

EXT2-fs: ide1(22,65): couldn't mount because of unsupported optional features (10000).
EXT3-fs: ide1(22,65): couldn't mount because of unsupported optional features (10000).

e2fsck is similarly unhelpful:
e2fsck: Filesystem has unsupported feature(s) while trying to open /dev/hdd1

The kernels on both machines have the same ext3 options enabled, and 
they're both 2.4.8-ac6.

This is the first time I've tried moving the drive like this - I 
assumed it would work flawlessly.  However, ext3 doco seems a bit
sparse under Documentation/, so I'm not quite sure about the recovery
steps needed.

I'd appreciate your help on this one :)  Please CC me in...

Regards,
Dewet

--
Dewet Diener     dewet@itouchlabs.com     -o)
Systems Administrator     iTouch Labs     / \
Self-confessed geek and Linux fanatic    _\_v

SYN! ..... SYN! ACK! ..... ACK!
The mating call of the internet


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279575AbRKATBm>; Thu, 1 Nov 2001 14:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279561AbRKATBd>; Thu, 1 Nov 2001 14:01:33 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:6385
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279566AbRKATBW>; Thu, 1 Nov 2001 14:01:22 -0500
Date: Thu, 1 Nov 2001 11:01:16 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Cached b0rked in 2.4.14-pre6
Message-ID: <20011101110116.A31193@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My cached has been decremented a few too many times on 2.4.14-pre6.  Right
now it's listing cached as "7516", but it was at 4GB not very long ago...

I know that Rik has posted a patch against 2.4.13-ac, but I don't know if
it's meant for 2.4.14-pre6 also...

I've seen another report of the same thing against 2.4.13 and 2.4.13-ac.
Here are the two kernels that I have seen this on (because I haven't tried
any inbetween):
vmlinuz-2.4.13freeswan-1.91+ac5+preempt+netdev_random+vm_freeswap
vmlinuz-2.4.14-pre6+preempt+netdev_random+ext3_0.9.14-2414p5

I'm running the bottom one now with seven hours uptime...

Mike

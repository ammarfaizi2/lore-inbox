Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBGVsD>; Wed, 7 Feb 2001 16:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbRBGVry>; Wed, 7 Feb 2001 16:47:54 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:18436 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129032AbRBGVrg>; Wed, 7 Feb 2001 16:47:36 -0500
Date: Thu, 8 Feb 2001 10:47:29 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Xuan Baldauf <xuan--reiserfs@baldauf.org>
Cc: David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
Message-ID: <20010208104729.B4749@metastasis.f00f.org>
In-Reply-To: <3A813A63.EBD1B768@namesys.com> <420500000.981560829@tiny> <20010207083854.F24270@spoke.nols.com> <3A818619.7C3967BC@baldauf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A818619.7C3967BC@baldauf.org>; from xuan--reiserfs@baldauf.org on Wed, Feb 07, 2001 at 06:30:01PM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 06:30:01PM +0100, Xuan Baldauf wrote:

    and so on. Maybe I should write a program which automatically
    detects and reports the zero blocks. I think the theory of tails
    unpacking does not work out, because there are also areas
    affected which are not between 2048 and 4096. Also the length of
    the zeroing can be greater than 2048.  However, I did not
    encounter a length of over 4096.

these appear on your system every couple of days right? if so... are
you able to run with the fs mount notails for a couple of days and
see if you still experience these?

my guess is you probably still will as most log files aren't
candidates for tail-packing (too large) but it will help eliminate
one more thing....


  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

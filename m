Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279064AbRJ2HtA>; Mon, 29 Oct 2001 02:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279065AbRJ2Hsu>; Mon, 29 Oct 2001 02:48:50 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:12539
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279064AbRJ2Hsg>; Mon, 29 Oct 2001 02:48:36 -0500
Date: Sun, 28 Oct 2001 23:48:59 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: PinkFreud <pf-kernel@mirkwood.net>
Cc: Chris Ahna <christopher.j.ahna@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Avoid a race in complete_change_console()
Message-ID: <20011028234859.C20280@mikef-linux.matchmail.com>
Mail-Followup-To: PinkFreud <pf-kernel@mirkwood.net>,
	Chris Ahna <christopher.j.ahna@intel.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0110281202130.15433-100000@eriador.mirkwood.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.20.0110281202130.15433-100000@eriador.mirkwood.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2001 at 12:25:14PM -0500, PinkFreud wrote:
> Chris, THANK YOU!  I've been having a problem on my SMP system for months
> now, where if I started X, switched to a text console, and then back to X,
> the system would lock up.  Your patch actually fixed it!
> 

I have seen this on 2.2 also.  Maybe it should be backported...

I've since changed my video card (from number nine t2r to permedia II),
upgraded X, and stopped switching from X to console so much...  So, I
haven't come across this problem since.

Mike

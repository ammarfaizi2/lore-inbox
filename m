Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278209AbRJRXdp>; Thu, 18 Oct 2001 19:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278203AbRJRXdh>; Thu, 18 Oct 2001 19:33:37 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:27149 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278209AbRJRXda>; Thu, 18 Oct 2001 19:33:30 -0400
Date: Fri, 19 Oct 2001 01:33:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org, forming@hotmail.com,
        Josh McKinney <forming@home.com>
Subject: Re: VM testing with mtest, 2.4.12-ac3 & 2.4.13pre3aa1
Message-ID: <20011019013358.V12055@athlon.random>
In-Reply-To: <20011018154225.A3833@cy599856-a.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011018154225.A3833@cy599856-a.home.com>; from forming@home.com on Thu, Oct 18, 2001 at 03:42:25PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 03:42:25PM -0500, Josh McKinney wrote:
> <2.4.12-ac3 vanilla>
> bytes allocated:                    134427443.2
> Elapsed (wall clock) time:          4.798
> <2.4.12-ac3+riel's hogstop&cache patch>
> bytes allocated:                    124885401.6
> Elapsed (wall clock) time:          4.401
> <2.4.13-pre3aa1>
> bytes allocated:                    288148684.8
> Elapsed (wall clock) time:          12.250

hmm, you should either fix the wall clock or fix the number of bytes
allocated.

If both are variable like in the above report any comparison is
impossible unfortunately.

Andrea

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271907AbSKECTy>; Mon, 4 Nov 2002 21:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271910AbSKECTx>; Mon, 4 Nov 2002 21:19:53 -0500
Received: from mhost.enel.ucalgary.ca ([136.159.102.8]:19411 "EHLO
	mhost.enel.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271907AbSKECTw>; Mon, 4 Nov 2002 21:19:52 -0500
Date: Mon, 4 Nov 2002 19:26:23 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Geoff Gustafson <geoff@linux.co.intel.com>
Cc: Christopher Yeoh <cyeoh@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Open POSIX Test Suite
Message-ID: <20021104192623.A14085@munet-d.enel.ucalgary.ca>
Mail-Followup-To: Geoff Gustafson <geoff@linux.co.intel.com>,
	Christopher Yeoh <cyeoh@samba.org>, linux-kernel@vger.kernel.org
References: <000a01c28454$56a94b90$7fd40a0a@amr.corp.intel.com> <15815.2399.566974.940599@gargle.gargle.HOWL> <016601c28464$6f6d1110$7fd40a0a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <016601c28464$6f6d1110$7fd40a0a@amr.corp.intel.com>; from geoff@linux.co.intel.com on Mon, Nov 04, 2002 at 04:44:01PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 04, 2002  16:44 -0800, Geoff Gustafson wrote:
> Another problem is the overhead of the TET framework. One of the goals of
> this the new test suite is to have test cases which are utterly minimal.
> So far, each test case has its own main() function and a bare minimum of
> surrounding code. The idea is that when a bug is found, this one .c file
> can be sent to the appropriate developer, and without any learning curve,
> they have the ability to find their bug. I don't think LKML wants to see
> TET code posted here. :)

Having suffered through using the TET framework for the Open Group POSIX
test suite, I would agree that using TET sucks.  The code is so convoluted
as to be useless, and it is nearly impossible to see from the output what
it is actually doing.

I agree that having a simple C or shell or perl script which is the entire
test, and the rest of the framework is external to it is very desirable.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

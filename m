Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317488AbSHCTiG>; Sat, 3 Aug 2002 15:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317504AbSHCTiF>; Sat, 3 Aug 2002 15:38:05 -0400
Received: from phobos.hpl.hp.com ([192.6.19.124]:41969 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317488AbSHCTiF>;
	Sat, 3 Aug 2002 15:38:05 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15692.12781.344389.519591@napali.hpl.hp.com>
Date: Sat, 3 Aug 2002 12:41:33 -0700
To: frankeh@watson.ibm.com
Cc: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Gerrit Huizenga <gh@us.ibm.com>, <Martin.Bligh@us.ibm.com>,
       <wli@holomorpy.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <200208031441.29353.frankeh@watson.ibm.com>
References: <15691.22889.22452.194180@napali.hpl.hp.com>
	<Pine.LNX.4.44.0208022125040.2694-100000@home.transmeta.com>
	<15691.24200.512998.875390@napali.hpl.hp.com>
	<200208031441.29353.frankeh@watson.ibm.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 3 Aug 2002 14:41:29 -0400, Hubertus Franke <frankeh@watson.ibm.com> said:

  Hubertus> But I'd like to point out that superpages are there to
  Hubertus> reduce the number of TLB misses by providing larger
  Hubertus> coverage. Simply providing page coloring will not get you
  Hubertus> there.

Yes, I agree.

It appears that Juan Navarro, the primary author behind the Rice
project, is working on breaking down the superpage benefits they
observed.  That would tell us how much benefit is due to page-coloring
and how much is due to TLB effects.  Here in our lab, we do have some
(weak) empirical evidence that some of the SPECint benchmarks benefit
primarily from page-coloring, but clearly there are others that are
TLB limited.

	--daivd

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbSJYOZI>; Fri, 25 Oct 2002 10:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261429AbSJYOZI>; Fri, 25 Oct 2002 10:25:08 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:18058 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261425AbSJYOZH>;
	Fri, 25 Oct 2002 10:25:07 -0400
Subject: Re: [Lse-tech] Re: [PATCH]updated ipc lock patch
From: Paul Larson <plars@linuxtestproject.org>
To: cmm@us.ibm.com
Cc: Andrew Morton <akpm@digeo.com>, Hugh Dickins <hugh@veritas.com>,
       manfred@colorfullife.com, lkml <linux-kernel@vger.kernel.org>,
       dipankar@in.ibm.com, lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <3DB880E8.747C7EEC@us.ibm.com>
References: <Pine.LNX.4.44.0210211946470.17128-100000@localhost.localdomain>
	<3DB86B05.447E7410@us.ibm.com> <3DB87458.F5C7DABA@digeo.com> 
	<3DB880E8.747C7EEC@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 25 Oct 2002 09:21:51 -0500
Message-Id: <1035555715.3447.150.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 18:23, mingming cao wrote:
> Thanks for your quick feedback.  I did LTP tests on it--it passed(well,
> I saw a failure on shmctl(), but the failure was there since 2.5.43
> kernel).  I will do more stress tests on it soon.
Which shmctl() test is this?  To my knowledge, there are no current
known issues with shmctl tests.  There is however one with sem02 in
semctl() that last I heard has been partially fixed in the kernel and
still needs to be fixed in glibc.  Is that the one you are referring to,
or is there really some other shmctl test in LTP that is failing?

Thanks,
Paul Larson


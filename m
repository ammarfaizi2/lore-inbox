Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265260AbSJXXVu>; Thu, 24 Oct 2002 19:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265448AbSJXXVu>; Thu, 24 Oct 2002 19:21:50 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:46502 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265260AbSJXXVt>; Thu, 24 Oct 2002 19:21:49 -0400
Message-ID: <3DB880E8.747C7EEC@us.ibm.com>
Date: Thu, 24 Oct 2002 16:23:20 -0700
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Hugh Dickins <hugh@veritas.com>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH]updated ipc lock patch
References: <Pine.LNX.4.44.0210211946470.17128-100000@localhost.localdomain> <3DB86B05.447E7410@us.ibm.com> <3DB87458.F5C7DABA@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> mingming cao wrote:
> >
> > Hi Andrew,
> >
> > Here is the updated ipc lock patch:
> 
> Well I can get you a bit of testing and attention, but I'm afraid
> my knowledge of the IPC code is negligible.
> 
> So to be able to commend this change to Linus I'd have to rely on
> assurances from people who _do_ understand IPC (Hugh?) and on lots
> of testing.

Thanks for your quick feedback.  I did LTP tests on it--it passed(well,
I saw a failure on shmctl(), but the failure was there since 2.5.43
kernel).  I will do more stress tests on it soon.

Mingming

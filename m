Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129163AbQKIMXy>; Thu, 9 Nov 2000 07:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130447AbQKIMXe>; Thu, 9 Nov 2000 07:23:34 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:51977 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129163AbQKIMXd>; Thu, 9 Nov 2000 07:23:33 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: "David S. Miller" <davem@redhat.com>
cc: torvalds@transmeta.com, aviro@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <CA256992.004406D2.00@d73mta05.au.ibm.com>
Date: Thu, 9 Nov 2000 17:46:53 +0530
Subject: Re: Oddness in i_shared_lock and page_table_lock nesting
	 hierarchies ?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > The fix we agreed on back then is easy (make rest of kernel match
 > vmtruncate()'s locking order), it just takes time to implement and
 > test.

  David,

  I was looking into the vmm code and trying to work out exactly how to fix
this, and there are
  some questions in my mind - mainly a few cases (involving multiple vma
updates) which
  I'm not sure about the cleanest way to tackle.
  But before I bother anyone with those, I thought I ought to go through
the earlier discussions
  that you had while coming up with what the fix should be. Maybe you've
already gone over
  this once.
  Could you point me to those ? Somehow I haven't been successful in
locating them.

  Regards
  Suparna


  Suparna Bhattacharya
  Systems Software Group, IBM Global Services, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265733AbSJYAQ4>; Thu, 24 Oct 2002 20:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265716AbSJYAQU>; Thu, 24 Oct 2002 20:16:20 -0400
Received: from dp.samba.org ([66.70.73.150]:12769 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265714AbSJYAQP>;
	Thu, 24 Oct 2002 20:16:15 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: dipankar@in.ibm.com
Cc: maneesh@in.ibm.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [long]2.5.44-mm3 UP went into unexpected trashing 
In-reply-to: Your message of "Thu, 24 Oct 2002 21:16:33 +0530."
             <20021024211633.A21583@in.ibm.com> 
Date: Fri, 25 Oct 2002 09:35:17 +1000
Message-Id: <20021025002228.A14712C2DD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021024211633.A21583@in.ibm.com> you write:
> AFAICS, find_first_bit() needs to be fixed to return "size" if the
> bitmask is all zeros.

Yes, the x86 one looks wrong.  Other archs seem to get this correct.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317730AbSHBCXS>; Thu, 1 Aug 2002 22:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317752AbSHBCXS>; Thu, 1 Aug 2002 22:23:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59807 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317730AbSHBCXR>;
	Thu, 1 Aug 2002 22:23:17 -0400
Date: Thu, 01 Aug 2002 19:14:49 -0700 (PDT)
Message-Id: <20020801.191449.101696880.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       vamsi_krishna@in.ibm.com
Subject: Re: [PATCH] kprobes for 2.5.30
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020802021635.D8A674CA5@lists.samba.org>
References: <20020802021635.D8A674CA5@lists.samba.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Fri, 02 Aug 2002 12:11:47 +1000

   	Vamsi's kernel probes again, this time with EXPORT_SYMBOL_GPL
   so people don't think this is blanket permission to hook into
   arbitrary parts of the kernel (as separate from debugging, testing,
   diagnostics, etc).
   
A nice enhancement would be to move the kprobe table and
other generic bits into a common area so that it did not
need to be duplicated as other arches add kprobe support.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293033AbSCFB6k>; Tue, 5 Mar 2002 20:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293047AbSCFB5M>; Tue, 5 Mar 2002 20:57:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5509 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293046AbSCFBz6>;
	Tue, 5 Mar 2002 20:55:58 -0500
Date: Tue, 05 Mar 2002 17:52:38 -0800 (PST)
Message-Id: <20020305.175238.102577593.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: sp@scali.com, adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: Does kmalloc always return address below 4GB?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15493.29045.798709.577904@napali.hpl.hp.com>
In-Reply-To: <15492.62946.952197.632931@napali.hpl.hp.com>
	<20020305.170909.78708394.davem@redhat.com>
	<15493.29045.798709.577904@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Tue, 5 Mar 2002 17:31:33 -0800
   
     DaveM> Your version is still broken then.
   
   Ah, classic DaveM.  You're obviously entitled to your opinion.

Look at all the problems that swiotlb pops up.  I'm not talking about
"can we make it work", but "can we make the performance not suck bad
when the thing is actually used".

IMHO highmem is the only clean and good performing solution for
>4GB machines without IOMMU.

You show me how to make swiotlb faster and more pretty, than we
can talk. :-)

So when someone tells me "on ia64, with 8gb ram, my eepro100 card gets
really crap performance under any load" I will explain the above to
them and let them know that the performance sucks because the ia64
folks refuse to integrate this bug fix :-)

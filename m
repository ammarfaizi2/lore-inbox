Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSHBNrA>; Fri, 2 Aug 2002 09:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSHBNq7>; Fri, 2 Aug 2002 09:46:59 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:60109 "EHLO e1.ny.us.ibm.com.")
	by vger.kernel.org with ESMTP id <S314277AbSHBNq5>;
	Fri, 2 Aug 2002 09:46:57 -0400
Date: Fri, 2 Aug 2002 19:30:35 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, vamsi_krishna@in.ibm.com
Subject: Re: [PATCH] kprobes for 2.5.30
Message-ID: <20020802193034.A14008@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <20020802021635.D8A674CA5@lists.samba.org> <20020801.191449.101696880.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020801.191449.101696880.davem@redhat.com>; from davem@redhat.com on Thu, Aug 01, 2002 at 07:14:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 07:14:49PM -0700, David S. Miller wrote:
>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Fri, 02 Aug 2002 12:11:47 +1000
> 
>    	Vamsi's kernel probes again, this time with EXPORT_SYMBOL_GPL
>    so people don't think this is blanket permission to hook into
>    arbitrary parts of the kernel (as separate from debugging, testing,
>    diagnostics, etc).
>    
> A nice enhancement would be to move the kprobe table and
> other generic bits into a common area so that it did not
> need to be duplicated as other arches add kprobe support.

Yes. We didn't do it in the first version of this patch to avoid
touching too many files. 

We do have the full version of dprobes which has generic bits
and arch-specific ones cleanly seperated. In fact, dprobes ports
are available for ia32, s390, s390x, ppc with ppc64 and ia64 ports
in early stages. Please check out:
http://www-124.ibm.com/linux/projects/dprobes/

Thanks,
--Vamsi

-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com

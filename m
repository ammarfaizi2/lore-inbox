Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313472AbSDQTBZ>; Wed, 17 Apr 2002 15:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313482AbSDQTBY>; Wed, 17 Apr 2002 15:01:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:3258 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313472AbSDQTBW>;
	Wed, 17 Apr 2002 15:01:22 -0400
Date: Thu, 18 Apr 2002 00:34:03 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.8: preemption + SMP broken ?
Message-ID: <20020418003403.B780@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020417232253.A629@in.ibm.com> <1019067957.1669.46.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 02:25:57PM -0400, Robert Love wrote:
> On Wed, 2002-04-17 at 13:52, Dipankar Sarma wrote:
> > Has anyone tried out preemption with SMP ?
> 
> Sure, all my testing is on SMP.  The problem manifested itself in
> 2.5.8-pre when some changes where made to the migration code.  The race
> is in the migration code - I am not sure it is preempts fault, per se,
> but the attached patch should fix it.  It is pending with Linus for the
> next release.

It worked! Thanks a lot, Robert.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

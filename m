Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267288AbTBEM6B>; Wed, 5 Feb 2003 07:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267310AbTBEM6B>; Wed, 5 Feb 2003 07:58:01 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:5780 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267288AbTBEM6B>;
	Wed, 5 Feb 2003 07:58:01 -0500
Date: Wed, 5 Feb 2003 18:40:07 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030205131007.GA1639@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <200302042011.h14KBuG6002791@darkstar.example.net> <200302050717.h157HTs16569@Port.imtp.ilyichevsk.odessa.ua> <jevfzzj9ov.fsf@sykes.suse.de> <200302051143.h15BhGs18013@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302051143.h15BhGs18013@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 01:41:34PM +0200, Denis Vlasenko wrote:
> My argument was against overusing optimization techniques.
> You cannot speed up kernel by aligning *everything* to 32 bytes,
> or by unrolling all loops, or by aggressive inlining.
> That's too easy to work. You get kernel which is bigger
> *and* slower.

I am not getting into this debate, just wanted to point out that
effect of compiler optimization on UNIX kernels have been studied
before. One paper I recall is  -

http://www.usenix.org/publications/library/proceedings/sf94/full_papers/partridge.ps

They used prfile-guided optimization, so that is whole another angle altogether.

Thanks
Dipankar

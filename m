Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290625AbSBLAPC>; Mon, 11 Feb 2002 19:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290627AbSBLAOm>; Mon, 11 Feb 2002 19:14:42 -0500
Received: from ns.suse.de ([213.95.15.193]:1296 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290620AbSBLAOf>;
	Mon, 11 Feb 2002 19:14:35 -0500
Date: Tue, 12 Feb 2002 01:09:11 +0100
From: Dave Jones <davej@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>, Robert Love <rml@tech9.net>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Arkadiy Chapkis - Arc <achapkis@mail.dls.net>,
        LINUX-KERNEL@vger.kernel.org
Subject: Re: thread_info implementation
Message-ID: <20020212010911.O4285@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>, Robert Love <rml@tech9.net>,
	Luigi Genoni <kernel@Expansa.sns.it>,
	Arkadiy Chapkis - Arc <achapkis@mail.dls.net>,
	LINUX-KERNEL@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202112140280.6590-100000@Expansa.sns.it> <1013460534.6784.477.camel@phantasy> <3C6855A2.4721DDD3@mandrakesoft.com> <20020211154917.A19367@are.twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020211154917.A19367@are.twiddle.net>; from rth@twiddle.net on Mon, Feb 11, 2002 at 03:49:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 03:49:17PM -0800, Richard Henderson wrote:

 > Though I seem to be having some problems with NFS.  Mount goes into D
 > state for quite some time and the portmapper complains about timeouts
 > connecting to localhost.  Anyone else see anything like that?  I suppose
 > I'll build an x86 kernel from the same source and see what I can find...

 Yes. I saw this start happening in my tree when I merged 2.5.4pre2
 When I tried a 2.5.4pre2 vanilla, the problem was gone, so I put it
 down to a problem in my tree. When I rebooted back into it, the problem
 was gone. Aren't heisenbugs fun?
 Exactly the same symptoms, portmap borken, NIS/NFS subsequently fail.
 This was on x86 btw.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

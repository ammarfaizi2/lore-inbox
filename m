Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292464AbSCANS7>; Fri, 1 Mar 2002 08:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292945AbSCANSt>; Fri, 1 Mar 2002 08:18:49 -0500
Received: from ns.suse.de ([213.95.15.193]:41994 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292464AbSCANSh>;
	Fri, 1 Mar 2002 08:18:37 -0500
Date: Fri, 1 Mar 2002 14:18:33 +0100
From: Dave Jones <davej@suse.de>
To: Marcin Gogolewski <marcing@ms-itti.com.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ops in Sched
Message-ID: <20020301141833.G7662@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Marcin Gogolewski <marcing@ms-itti.com.pl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020301130827Z292988-889+115853@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020301130827Z292988-889+115853@vger.kernel.org>; from marcing@ms-itti.com.pl on Fri, Mar 01, 2002 at 02:08:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 02:08:38PM +0100, Marcin Gogolewski wrote:
 > 
 > I hav to send it as attachement because of virus alert.

 *sigh*, these things are getting really silly.
 I associate the first of the month with mailman reminder day,
 but it seems today has been 'dumb virus-scanner MTA day' so far.
 
 > Process ksoftirq_CPU0(pid:3, stackpage=f7df5000)
 > Stack: c02918e2 00000236 00000000 00000000 00000018 c0320018 f7df4000 c0121660
 > 00000000 f7df4000 00000246 00000000 f7df4000 f7df4000 00000000 c0121ca1
 > 00000000 00010f00 c2113fac 00000000 c0350f40 c0105766 00000000 c0121bb0
 > Call Trace:[<c0121660>][<c0121ca1>][<c0105766>][<c0121bb0>]
 > Code:0f 0b 56 5e 8b 55 ec 8b 4a 1c 85 c9 78 3e 81 3d 04 84 32 c0

 Feed this through ksymoops to decode the addresses, and then
 it becomes 100% more useful.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267612AbSLSKfu>; Thu, 19 Dec 2002 05:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267613AbSLSKft>; Thu, 19 Dec 2002 05:35:49 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:53508 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267612AbSLSKfs>; Thu, 19 Dec 2002 05:35:48 -0500
Message-Id: <200212191026.gBJAQQs28394@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [Lse-tech] Re: 15000+ processes -- poor performance ?!
Date: Thu, 19 Dec 2002 13:15:35 -0200
X-Mailer: KMail [version 1.3.2]
Cc: David Lang <david.lang@digitalinsight.com>, Robert Love <rml@tech9.net>,
       Till Immanuel Patzschke <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
References: <1040262178.855.106.camel@phantasy> <200212191015.gBJAFss28329@Port.imtp.ilyichevsk.odessa.ua> <20021219102720.GT31800@holomorphy.com>
In-Reply-To: <20021219102720.GT31800@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 December 2002 08:27, William Lee Irwin III wrote:
> On 19 December 2002 00:05, William Lee Irwin III wrote:
> >> Well, a better solution would be a userspace free of /proc/
> >> dependency.
> >> Or actually fixing the kernel. proc_pid_readdir() wants an
> >> efficiently indexable linear list, e.g. TAOCP's 6.2.3 "Linear List
> >> Representation". At that point its expense is proportional to the
> >> buffer size and "seeking" about the list as it is wont to do is
> >> O(lg(processes)).
>
> On Thu, Dec 19, 2002 at 01:05:03PM -0200, Denis Vlasenko wrote:
> > A short-time solution: run top d 30 to make it refresh only every
> > 30 seconds. This will greatly reduce top's own load skew.
>
> As userspace solutions go your suggestions is just as good. The
> kernel still needs to get its act together and with some urgency.

That was just a suggestion as to how to get realistic picture
of system load for Till Immanuel Patzschke <tip@inw.de>.
--
vda

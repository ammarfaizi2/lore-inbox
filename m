Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWGKUI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWGKUI5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWGKUI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:08:57 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:694 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751214AbWGKUI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:08:56 -0400
Date: Tue, 11 Jul 2006 13:00:27 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 adds smp_call_function_single
Message-ID: <20060711200027.GB29402@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060711132422.GB28851@frankl.hpl.hp.com> <20060711175239.GI5362@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711175239.GI5362@redhat.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

On Tue, Jul 11, 2006 at 01:52:39PM -0400, Dave Jones wrote:
> On Tue, Jul 11, 2006 at 06:24:22AM -0700, Stephane Eranian wrote:
>  > Hello,
>  > 
>  > Continiung the series of small patches necessary for the perfmon subsystem, here
>  > is a patch that adds support for the smp_call_function_single() function for i386.
>  > It exists for almost all other architectures but i386. The perfmon subsystem
>  > needs it in one case to free some state on a designated remote CPU.
>  > 
>  > Changelog:
>  > 	- adds smp_call_function_single() to i386 tree. This function
>  > 	  is used to invoked a procedure on a designated remote CPU.
> 
> The naming seems a little strange to me.  Something like
> run_on_cpu() would be clearer.  Less keystrokes too :)
> 

I agree with you that the name is a bit long but I did not invent it.
The same function name is used for this functionality on IA-64 and X86-64.

--
-Stephane

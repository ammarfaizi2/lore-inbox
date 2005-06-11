Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVFKOqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVFKOqK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 10:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVFKOqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 10:46:09 -0400
Received: from opersys.com ([64.40.108.71]:27908 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261725AbVFKOpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 10:45:33 -0400
Message-ID: <42AAF7A7.4010406@opersys.com>
Date: Sat, 11 Jun 2005 10:39:35 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       mingo@elte.hu, pmarques@grupopie.com, bruce@andrew.cmu.edu, ak@muc.de,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
References: <42AA6A6B.5040907@opersys.com>  <42AA812D.2060701@yahoo.com.au> <1118481315.9519.39.camel@sdietrich-xp.vilm.net>
In-Reply-To: <1118481315.9519.39.camel@sdietrich-xp.vilm.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sven-Thorsten Dietrich wrote:
> I am too looking forward to seeing results against the >= 07.48 RT
> kernels incorporating Daniel's recent IRQ disable relief.

Indeed, this is on our list.

> I think the comparison should absolutely compare identical community
> kernels. The comparison between two different release candidates is
> questionable. rc2 to rc4 doesn't seem like much, after all, how much
> code could go into a release candidate. (diff | wc -l) 
> 
> Also, I question testing -rc code in the first place, except for
> regression purposes. 

On this issue, it has to be said that I don't think any set of test
results will suffice on its own as a definitive benchmark. There will
be a need for continued testing and publication of said results, which
we hope others will take part in when we publish the framework we've put
together.

> Finally, there are other big-picture issues. How hard is it to maintain
> the code in general? At the risk of ruffling feathers, forward-porting
> RT code (or backporting) it a few revisions of rc's isn't too bad. 
> 
> At Ingo's pace, we have all done some of that.
> 
> How does that effort compare for porting ADEOS code? If several weeks of
> work are invested in a comparison of rc2 to rc4, how much additional
> work is needed to bring Adeos up to the base for the current RT kernel?

Philippe can correct me if I'm wrong, but adeos maintenance is not that
difficult. However, it has to be said that up until now, Philippe has been
the main driving force behind adeos. So while he's been fairly good at
publishing patches for as recent a kernel as possible, the manpower behind
PREEMPT_RT is obviously larger. That, though, only requires interested
parties to participate for it to change. Again, the adeos patch isn't
that big.

> In addition, I think the discrepancy between the vanilla kernel and the
> RT kernel could be much greater, if the workload specifically, or even
> coincidentally exercised bottlenecks.

If you've got any specific test run suggestions, we'll gladly take them.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

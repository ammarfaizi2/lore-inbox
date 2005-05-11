Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVEKBdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVEKBdo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 21:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVEKBdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 21:33:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11712 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261863AbVEKBdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 21:33:41 -0400
Date: Tue, 10 May 2005 21:33:34 -0400
From: Dave Jones <davej@redhat.com>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Cc: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org,
       cpufreq@zenii.linux.org.uk, linux@dominikbrodowski.net
Subject: Re: cpufreq on-demand governor up_treshold?
Message-ID: <20050511013334.GB8039@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Eric Piel <Eric.Piel@tremplin-utc.net>,
	Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org,
	cpufreq@zenii.linux.org.uk, linux@dominikbrodowski.net
References: <200503140829.04750.lkml@kcore.org> <42354400.7070500@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42354400.7070500@tremplin-utc.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 08:57:52AM +0100, Eric Piel wrote:
 > Jan De Luyck a écrit :
 > >Hello lists,
 > >
 > >(please cc me from cpufreq list)
 > >
 > >I've since yesterday started using the ondemand governor. Seems to work 
 > >fine, tho I can't seem to find a reason why it keeps scaling my processor 
 > >speed upwards tho the processor use never exceeds 30% (been watching top 
 > >-d 1). 
 > :
 > :
 > >Any hints?
 > You can try the three attached patches in the order :
 > ondemand-cleanup-factorise-idle-measurement-2.6.11.patch
 > ondemand-save-idle-up-for-all-cpu-2.6.11.patch
 > ondemand-automatic-downscaling-2.6.11-accepted.patch
 > 
 > They are available on the cpufreq list but as it's difficult to access 
 > it I'm sending them again, all together. These are the last things that 
 > Venki and I have been working on. It should solve your problem 
 > (actually, only the last patch, but it depends on the two previous 
 > patches). Please, let me know if it works.
 > 
 > BTW, DaveJ, Dominik, I couldn't find them in the daily-snapshot 
 > available at codemonkey.org.uk. Should I worry, or is it just due to 
 > some latency between your private trees and the public one?

I'm preparing the first cpufreq->linus sync right now.
Can you write up some descriptions & signed-off-by: lines for
these three please ?

Thanks,
		Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbUK3KuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbUK3KuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 05:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbUK3KuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 05:50:07 -0500
Received: from poup.poupinou.org ([195.101.94.96]:32004 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S262039AbUK3KuB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 05:50:01 -0500
Date: Tue, 30 Nov 2004 11:49:47 +0100
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: efficeon and longrun
Message-ID: <20041130104947.GA5744@poupinou.org>
References: <16810.26231.936086.930240@metzlerbros.de> <cogd81$2nt$1@terminus.zytor.com> <Pine.LNX.4.61.0411291835500.18845@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411291835500.18845@twinlark.arctic.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Bruno Ducrot <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 29, 2004 at 07:45:55PM -0800, dean gaudet wrote:
> On Tue, 30 Nov 2004, H. Peter Anvin wrote:
> 
> > longrun-0.9 is hideously out of date, and was never debugged to begin
> > with.  Given that these days longrun is handled via cpufreq, there
> > doesn't seem to be much reason for the standalone longrun program.
> 
> the tool still has a place... for folks not using cpufreq/2.6 especially.  

There is still a cpufreq/2.4 that I try sometimes to maintain and
support longrun.

> but also the longrun cpufreq driver is lacking support for 
> scaling_available_frequencies, and doesn't display the voltages anywhere.  
> in most cases the ACPI P-states driver works fine instead though.

That may be added if you justifies that enough.  Apparently, you want a
fixed frequency cpufreq driver for longrun?

> i prefer the tool -- but then my requirements are pretty specific (i don't 
> want cpufreq doing anything i'm not expecting while doing perf/debugging 
> work).

cpufreq can help you IMHO. All the stuff you want can be done probably via
cpufreq.  Debugging support, governors for your perf work if this is
done in kernel space, notifier interface, and last but not the
least, a more generic infrastructure so that you can change
processors or architectures at will.

Please ask what you need exactly but at the cpufreq mailing list.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

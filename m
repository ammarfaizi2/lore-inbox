Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbTJSNyk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 09:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTJSNyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 09:54:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19460 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261639AbTJSNyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 09:54:38 -0400
Date: Sun, 19 Oct 2003 14:54:29 +0100
From: Dave Jones <davej@redhat.com>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8: cpufreq longhaul probs..still :-(
Message-ID: <20031019135429.GA8924@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jurgen Kramer <gtm.kramer@inter.nl.net>,
	linux-kernel@vger.kernel.org
References: <1066475780.2607.6.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066475780.2607.6.camel@paragon.slim>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 01:16:21PM +0200, Jurgen Kramer wrote:

 > With test8 there are still problems with the longhaul cpufreq stuff:
 > 
 > longhaul: VIA C3 'Ezra' [C5C] CPU detected. Longhaul v1 supported.
 > longhaul: MinMult=3.0x MaxMult=6.0x
 > longhaul: FSB: 0MHz Lowestspeed=0MHz Highestspeed=0MHz

*boggle*, we had these fixed I thought..

I'm going to need you to litter the code with printk's to find out
why your MSRs are returning zeros. Contact me off list if you want
a patch to do this, otherwise.. don't be afraid to go overboard,
the more debug info the better.

 > I'll check if I can fix the min/max freq. Is Longhaul v1 correct for
 > this CPU? With cpufreq from 2.4 it always displays v2.

According to the documentation, yes.

		Dave


-- 
 Dave Jones     http://www.codemonkey.org.uk

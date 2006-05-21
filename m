Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWEUAMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWEUAMV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 20:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWEUAMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 20:12:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7555 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932219AbWEUAMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 20:12:20 -0400
Date: Sat, 20 May 2006 20:12:17 -0400
From: Dave Jones <davej@redhat.com>
To: Ameer Armaly <ameer@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] i386 warning cleanups that work
Message-ID: <20060521001217.GB30269@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ameer Armaly <ameer@bellsouth.net>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0605201957070.3380@sg1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605201957070.3380@sg1>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006 at 07:59:17PM -0400, Ameer Armaly wrote:

 > diff --git a/arch/i386/kernel/cpu/transmeta.c 
 > b/arch/i386/kernel/cpu/transmeta.c
 > index 7214c9b..0737890 100644
 > --- a/arch/i386/kernel/cpu/transmeta.c
 > +++ b/arch/i386/kernel/cpu/transmeta.c
 > @@ -9,7 +9,7 @@ static void __init init_transmeta(struct
 >  {
 >  	unsigned int cap_mask, uk, max, dummy;
 >  	unsigned int cms_rev1, cms_rev2;
 > -	unsigned int cpu_rev, cpu_freq, cpu_flags, new_cpu_rev;
 > +	unsigned int cpu_rev, cpu_freq = 0, cpu_flags, new_cpu_rev;
 >  	char cpu_info[65];
 > 
 >  	get_model_name(c);	/* Same as AMD/Cyrix */

http://www.gossamer-threads.com/lists/linux/kernel/647975?page=last

		Dave

-- 
http://www.codemonkey.org.uk

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbTAITON>; Thu, 9 Jan 2003 14:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266969AbTAITON>; Thu, 9 Jan 2003 14:14:13 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:34028 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266965AbTAITOM>;
	Thu, 9 Jan 2003 14:14:12 -0500
Date: Thu, 9 Jan 2003 19:20:22 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Corey Minyard <minyard@acm.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PATCH: IPMI driver
Message-ID: <20030109192022.GA5693@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Corey Minyard <minyard@acm.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200301090332.h093WML05981@hera.kernel.org> <20030109164407.GA26195@codemonkey.org.uk> <1042135594.27796.37.camel@irongate.swansea.linux.org.uk> <20030109172229.GA27288@codemonkey.org.uk> <1042135971.27796.44.camel@irongate.swansea.linux.org.uk> <3E1DCA8D.4040005@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1DCA8D.4040005@acm.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 01:16:29PM -0600, Corey Minyard wrote:

 > >Pull the 2.5 port from openipmi.sourceforge.net  saves you doing the port
 > >yourself. 
 > >
 > Definately pull the 2.5 port from there, as there are some differences 
 > between the 2.4 and 2.5 versions.

I had a quick skim through the patch.
Is the handling of jiffies wraps done correctly ? It doesn't
look like it...

time_diff = ((jiffies_now - kcs_info->last_timeout_jiffies)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk

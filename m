Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266975AbTAITa7>; Thu, 9 Jan 2003 14:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266978AbTAITa7>; Thu, 9 Jan 2003 14:30:59 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:38380 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266975AbTAITa7>;
	Thu, 9 Jan 2003 14:30:59 -0500
Date: Thu, 9 Jan 2003 19:37:10 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Corey Minyard <minyard@acm.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PATCH: IPMI driver
Message-ID: <20030109193710.GA6740@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Corey Minyard <minyard@acm.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200301090332.h093WML05981@hera.kernel.org> <20030109164407.GA26195@codemonkey.org.uk> <1042135594.27796.37.camel@irongate.swansea.linux.org.uk> <20030109172229.GA27288@codemonkey.org.uk> <1042135971.27796.44.camel@irongate.swansea.linux.org.uk> <3E1DCA8D.4040005@acm.org> <20030109192022.GA5693@codemonkey.org.uk> <1042143476.27796.66.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042143476.27796.66.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 08:17:57PM +0000, Alan Cox wrote:
 > On Thu, 2003-01-09 at 19:20, Dave Jones wrote:
 > > time_diff = ((jiffies_now - kcs_info->last_timeout_jiffies)
 > 
 > Thats valid for unsigned maths
 > 	0x00000001 - 0xFFFFFFFF = 0x00000002

Doh, I've made this mistake before.. Thanks for clarifying.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk

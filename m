Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266969AbTAITXX>; Thu, 9 Jan 2003 14:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbTAITXX>; Thu, 9 Jan 2003 14:23:23 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16526
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266969AbTAITXW>; Thu, 9 Jan 2003 14:23:22 -0500
Subject: Re: [PATCH] PATCH: IPMI driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Corey Minyard <minyard@acm.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030109192022.GA5693@codemonkey.org.uk>
References: <200301090332.h093WML05981@hera.kernel.org>
	 <20030109164407.GA26195@codemonkey.org.uk>
	 <1042135594.27796.37.camel@irongate.swansea.linux.org.uk>
	 <20030109172229.GA27288@codemonkey.org.uk>
	 <1042135971.27796.44.camel@irongate.swansea.linux.org.uk>
	 <3E1DCA8D.4040005@acm.org>  <20030109192022.GA5693@codemonkey.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042143476.27796.66.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 09 Jan 2003 20:17:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 19:20, Dave Jones wrote:
> time_diff = ((jiffies_now - kcs_info->last_timeout_jiffies)

Thats valid for unsigned maths
	0x00000001 - 0xFFFFFFFF = 0x00000002

Alan


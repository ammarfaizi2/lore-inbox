Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261966AbSI3IYA>; Mon, 30 Sep 2002 04:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261967AbSI3IYA>; Mon, 30 Sep 2002 04:24:00 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:59890 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S261966AbSI3IX7>; Mon, 30 Sep 2002 04:23:59 -0400
Date: Mon, 30 Sep 2002 01:22:00 -0700
From: Chris Wright <chris@wirex.com>
To: James Morris <jmorris@intercode.com.au>
Cc: Greg KH <greg@kroah.com>,
       Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] accessfs v0.6 ported to 2.5.35-lsm1 - 1/2
Message-ID: <20020930012200.G12641@figure1.int.wirex.com>
Mail-Followup-To: James Morris <jmorris@intercode.com.au>,
	Greg KH <greg@kroah.com>,
	Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <20020927214642.GS12909@kroah.com> <Mutt.LNX.4.44.0209292236200.27145-100000@blackbird.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Mutt.LNX.4.44.0209292236200.27145-100000@blackbird.intercode.com.au>; from jmorris@intercode.com.au on Sun, Sep 29, 2002 at 10:56:33PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@intercode.com.au) wrote:
> > 
> > As for the ip_prot_sock hook in general, does it look ok to the other
> > developers?
> 
> This hook is not necessary: any related access control decision can be
> made via the more generic and flexible socket_bind() hook (like SELinux).

Yes, I had the same impression.
thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

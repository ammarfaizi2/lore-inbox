Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135977AbRD0FXC>; Fri, 27 Apr 2001 01:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135978AbRD0FWy>; Fri, 27 Apr 2001 01:22:54 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:53001 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S135977AbRD0FWk>;
	Fri, 27 Apr 2001 01:22:40 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15080.63914.128198.622684@argo.ozlabs.ibm.com.au>
Date: Fri, 27 Apr 2001 14:46:34 +1000 (EST)
To: Marcell GAL <cell@sch.bme.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 oopses at lots of ppp sessions
In-Reply-To: <3AE85451.D197FCB9@sch.bme.hu>
In-Reply-To: <3AE85451.D197FCB9@sch.bme.hu>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcell GAL writes:

> 2.4.3 (UP kernel UP machine, http://home.sch.bme.hu/~cell/.config) 
> oopses when I start lots of pppd eth0 simultaneously.
> (I guess the problem is not pppoe specific, but I do not know exactly)
> 
> The last pppd sighs: PPP: couldn't register device (-17)
> This is 2 oops not just 1...

Hmmm, somehow the list of ppp units has got a null pointer in it.  At
the moment I don't see how that can happen, but I will look into it.

Paul.

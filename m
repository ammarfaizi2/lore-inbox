Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbUKSH2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbUKSH2c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 02:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbUKSH2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 02:28:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:62605 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261241AbUKSH23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 02:28:29 -0500
Date: Thu, 18 Nov 2004 23:28:27 -0800
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ross Kendall Axe <ross.axe@blueyonder.co.uk>, netdev@oss.sgi.com,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when using SELinux and SOCK_SEQPACKET
Message-ID: <20041118232827.X2357@build.pdx.osdl.net>
References: <20041118230109.V2357@build.pdx.osdl.net> <Xine.LNX.4.44.0411190209090.8343-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Xine.LNX.4.44.0411190209090.8343-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Fri, Nov 19, 2004 at 02:12:58AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@redhat.com) wrote:
> For sendto():
>   "If the socket is connection-mode, dest_addr shall be ignored."

Yup, I read right past it, thanks.  Guess the standards have spoken ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

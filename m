Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbUKRGJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbUKRGJe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 01:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbUKRGJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 01:09:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:55186 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262613AbUKRGID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 01:08:03 -0500
Date: Wed, 17 Nov 2004 22:07:59 -0800
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: Ross Kendall Axe <ross.axe@blueyonder.co.uk>, netdev@oss.sgi.com,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when using SELinux and SOCK_SEQPACKET
Message-ID: <20041117220756.N2357@build.pdx.osdl.net>
References: <Xine.LNX.4.44.0411172222160.2531-100000@thoron.boston.redhat.com> <Xine.LNX.4.44.0411172323260.2700-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Xine.LNX.4.44.0411172323260.2700-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Wed, Nov 17, 2004 at 11:25:39PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@redhat.com) wrote:
> On Wed, 17 Nov 2004, James Morris wrote:
> 
> > There is a non SELinux-related bug lurking in this code.
> 
> I also got this when trying to kill the server (which seems to run at 100% 
> during exit after receving a message sent with sendto() + address):

I was seeing similar with my test (w/out SELinux), but got garbage for
back trace.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

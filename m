Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTHZANA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 20:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTHZANA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 20:13:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37387 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262193AbTHZAM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 20:12:59 -0400
Date: Tue, 26 Aug 2003 10:12:45 +1000 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jamesm@excalibur.intercode.com.au
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: selinux build failure
In-Reply-To: <20030825095055.7d73b93b.rddunlap@osdl.org>
Message-ID: <Mutt.LNX.4.44.0308261011001.1041-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Aug 2003, Randy.Dunlap wrote:

> Yes, the second patch fixes for me also.  [2.6.0-test4 now]
> I also see the warnings below.
> 
> | security/selinux/hooks.c: In function `selinux_bprm_set_security':
> | security/selinux/hooks.c:1384: warning: cast to pointer from integer of different size
> | security/selinux/hooks.c:1430: warning: cast to pointer from integer of different size
> | security/selinux/hooks.c: In function `selinux_bprm_compute_creds':
> | security/selinux/hooks.c:1520: warning: cast from pointer to integer of different size
> | security/selinux/hooks.c: In function `selinux_getprocattr':
> | security/selinux/hooks.c:3147: warning: passing arg 3 of `security_sid_to_context' from incompatible pointer type
> 

Yep, a fix for this is forthcoming.


- James
-- 
James Morris
<jmorris@redhat.com>


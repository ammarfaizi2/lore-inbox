Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031412AbWLGFyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031412AbWLGFyZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 00:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031422AbWLGFyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 00:54:25 -0500
Received: from ozlabs.org ([203.10.76.45]:48713 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031412AbWLGFyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 00:54:24 -0500
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: linux-kernel@vger.kernel.org, H Peter Anvin <hpa@zytor.com>,
       Andrew Morton <akpm@osdl.org>, Al Viro <viro@ftp.linux.org.uk>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] Add retain_initrd boot option 
In-reply-to: <4577A91E.70501@oracle.com> 
References: <20614.1165469597@neuling.org> <4577A91E.70501@oracle.com>
Comments: In-reply-to Randy Dunlap <randy.dunlap@oracle.com>
   message dated "Wed, 06 Dec 2006 21:39:42 -0800."
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 21.4.1
Date: Thu, 07 Dec 2006 16:54:22 +1100
Message-ID: <21586.1165470862@neuling.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -#ifdef CONFIG_KEXEC
> >  	unsigned long crashk_start = (unsigned long)__va(crashk_res.start);
> >  	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
> 
> I'm still not seeing how using crashk_res is valid here when
> CONFIG_KEXEC=n.  Can you explain that, please?
> You did test this with KEXEC=y and KEXEC=n, right?

Yeah, you'd think I would but apparently not.  Sorry, re-sending.

Mikey

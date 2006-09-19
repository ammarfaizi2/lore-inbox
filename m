Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWISGNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWISGNi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 02:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWISGNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 02:13:38 -0400
Received: from mail.gmx.de ([213.165.64.20]:47062 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964973AbWISGNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 02:13:37 -0400
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 19 Sep 2006 08:13:35 +0200
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
In-Reply-To: <005501c6db44$102b73a0$294b82ce@stuartm>
Message-ID: <20060919061335.113810@gmx.net>
MIME-Version: 1.0
References: <005501c6db44$102b73a0$294b82ce@stuartm>
Subject: Re: RE: TCP stack behaviour question
To: "Stuart MacDonald" <stuartm@connecttech.com>, ak@suse.de
X-Authenticated: #24879014
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Von: "Stuart MacDonald" <stuartm@connecttech.com>

> > > Ok maybe it's a bit misleading. Michael, you might want to clarify.
> > 
> > Can some one of you propose a better text please?
> 
> Perhaps
> 
> Note that TCP has no error queue; MSG_ERRQUEUE is illegal on
> SOCK_STREAM sockets.  IP_RECVERR is valid for TCP, but all errors are
> returned by socket function return or SO_ERROR only.
> 
> ?

Sound okay to you Andi?

Cheers,

Michael
-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTKYIP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 03:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbTKYIP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 03:15:57 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:6854 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262101AbTKYIP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 03:15:56 -0500
From: Amon Ott <ao@rsbac.org>
Organization: RSBAC
To: linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems
Date: Tue, 25 Nov 2003 09:15:57 +0100
User-Agent: KMail/1.5.4
References: <200311241736.23824.jlell@JakobLell.de> <bpu5fk$vsn$1@gatekeeper.tmr.com> <20031124163553.B16684@osdlab.pdx.osdl.net>
In-Reply-To: <20031124163553.B16684@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311250915.57221.ao@rsbac.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 25. November 2003 01:35, Chris Wright wrote:
> * bill davidsen (davidsen@tmr.com) wrote:
> > 
> > While I think you're overblowing the problem, it is an issue which might
> > be addressed in SE Linux or somewhere. I have an idea on that, but I
> > want to look before I suggest anything.
> 
> SELinux controls hard link creation by checking, among other things,
> the security context of the process attempting the link, and the security
> context of the target (oldpath).  Other MAC systems do similar, and some
> patches such as grsec and owl simply disable linking to files the user
> can't read/write to for example.

..and in RSBAC, LINK_HARD has been a controlled separate type of access since 
the very first version back in 1997. It has always been treated like a write 
access to the target file by all decision modules, because of the 
implications mentioned in this thread.

Amon.
-- 
http://www.rsbac.org - GnuPG: 2048g/5DEAAA30 2002-10-22


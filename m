Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290808AbSBFVIw>; Wed, 6 Feb 2002 16:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290810AbSBFVIe>; Wed, 6 Feb 2002 16:08:34 -0500
Received: from quark.didntduck.org ([216.43.55.190]:61445 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S290808AbSBFVIR>; Wed, 6 Feb 2002 16:08:17 -0500
Message-ID: <3C619B36.95E43E0D@didntduck.org>
Date: Wed, 06 Feb 2002 16:08:06 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Applying 2.5.4-pre1 patch
In-Reply-To: <3C6119E2.2060504@wanadoo.fr> <3C619586.92EAED50@mandrakesoft.com> <3C619927.2020601@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet wrote:
> 
> Jeff Garzik wrote:
> > Pierre Rousselet wrote:
> >
> >>Patching drivers/char/gameport with /dev/null doesn't work for me. What
> >>is the trick ?
> >>
> >
> > /dev/null indicates a new, or a removed, file.
> 
> 'patch -p0 < patch' is confused by this : "sure you want to delete this
> file ?"
> 
> Are there some arguments to add on the cmd line ?

Use patch -p1.  Also, make sure you are using an up to date version of
patch.

--

				Brian Gerst

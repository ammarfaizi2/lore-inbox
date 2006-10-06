Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932633AbWJFGmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbWJFGmM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 02:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbWJFGmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 02:42:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:1924 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932633AbWJFGmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 02:42:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GSnSaoc1gEXbwtQaZY6286zcsNQHwt43yn1/SBYAj/awD1RIEgwUzoHPkaJO4JoHfmdl0JIm2hkAAp8n++lEnN/sZ+IXdV6yjou6EM4iC5qPcA8840stxGZy9aVcn06VzFInmBKLsxnvIe7E86BC3uZ0LGJVT0HguK+NuUSi4AI=
Message-ID: <d4e708d60610052341v8e8718cpfca5b60a28bfc93b@mail.gmail.com>
Date: Fri, 6 Oct 2006 08:41:56 +0200
From: "koos vriezen" <koos.vriezen@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: Linux 2.6.18 break scratchbox
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061004213521.GA8667@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d4e708d60610030759h23a037aega70acb44bff1b524@mail.gmail.com>
	 <20061004213521.GA8667@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/10/4, Pavel Machek <pavel@ucw.cz>:
> Hi!
>
> > Hit by http://bugzilla.scratchbox.org/bugzilla/show_bug.cgi?id=279 I
> > wondered why such
> > a change that could break existing setups entered 2.6.18.
> > Now I can peek through '/proc/<pid of process outside chroot env w/ my
> > UID>/root' into the
> > box's root (and that's why scratchbox is broken now).
>
> File bug at bugzilla.kernel.org :-).
>
> I'm afraid we did not know about this ABI change, and noone using
> scratchbox tested 2.6.18-rcX...

Well I did google for this before this report and eg.
http://nchip.livejournal.com/ already mentioned it (but probably
didn't report it at lkml) and there where some other links.
But since I couldn't find any info on this new feature, that one can
now read and write file through the /proc/xx/root link, I ask it here.
And hopefully, if it's a regression, would be fixed in the stable tree
ASAP. (Somehow I almost can't believe this change wouldn't show
immediately in a regression test setup, and there must be a reason for
opening this door w/o using an axe).

Koos
>                                                                 Pavel

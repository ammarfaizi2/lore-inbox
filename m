Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270416AbTHLOF7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 10:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270426AbTHLOF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 10:05:59 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:53440 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S270416AbTHLOF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 10:05:57 -0400
Date: Tue, 12 Aug 2003 16:06:09 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 cannot mount root fs
Message-ID: <20030812140609.GB1926@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Andrey Borzenkov <arvidjaar@mail.ru>,
	linux-kernel@vger.kernel.org
References: <E19mZ6L-000Jrv-00.arvidjaar-mail-ru@f22.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E19mZ6L-000Jrv-00.arvidjaar-mail-ru@f22.mail.ru>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 05:22:13PM +0400, "Andrey Borzenkov"  wrote:
> 
> >>        cannot mount rootfs "NULL" or hdb1
> >
> > AFAIK, there is no such message in 2.6.0-test3 ...
> 
> there is

please provide the file and line number, where
linux-2.6.0-test3 contains the string "cannot mount rootfs".
(or where this string is synthesized)
I am not able to locate it ...

> > if, on the other hand, the message looks like ...
> >
> > -----------
> > VFS: Cannot open root device "hdb1" or unknown-block(0,0)
> > Please append a correct "root=" boot option
> > -----------
> 
> he does not pass it in append line. He is using root= option in lilo.
> actually my lilo does pass "root=341" in this case while the above means lilo omits any root= command line option and relies on compiled-in ROOT_DEV

already suggested that, but he says, it doesn't
work either ... 

best,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

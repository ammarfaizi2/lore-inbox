Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWAQRjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWAQRjg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWAQRjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:39:36 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:38644 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932244AbWAQRjf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:39:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=cPV78o+zZVk7oH5EiryF0xoTuai/uhkhd4XcFBskkub7R94ZeRMNmuS+TPbQKXz/h4Cs2bLZoPyfscfegSDacIKlsqf9T5Ks75SOJIBrV+o7ujTwSQeLyPEqeJBygqPiu10CmynpgDKnW/cZheWb+HfqxuAjRZEyK47gV2NvPrk=
Date: Tue, 17 Jan 2006 18:39:16 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc1
Message-Id: <20060117183916.399b030f.diegocg@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 17 Jan 2006 00:19:56 -0800 (PST),
Linus Torvalds <torvalds@osdl.org> escribió:

> Anyway, it's out there now. The ShortLog is pretty readable - if you are 
> into that kind of stuff - but as usual for an -rc1 release (which has all 
> the frantic merging going on), it's actually too big to post on the kernel 
> list due to the size limits. It's weighs in at 4000+ lines and 169kB.

Can I ask if it's possible to "mark" new features/important changes?

I've maintaining http://wiki.kernelnewbies.org/LinuxChanges
for three releases and the amount of changes is so big it takes hours 
to extract the relevant changes, adding some special string in the 
description field could help to automate this process and make better
changelogs.

It's not only better for me, I also know there're more people ej: man
page maintainers looking at the full changelogs to find out if 
something has changed. There're lot of nice things being merged on 
each release, but there's not a way to tell people that those features 
exist; even kernel developers don't really know what is going on in 
other parts of the kernel. A "useful" changelog is one of the few
things the linux kernel has been missing for ages, IMO ;)

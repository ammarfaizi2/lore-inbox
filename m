Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVFSPEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVFSPEu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 11:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVFSPEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 11:04:50 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:6816 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262238AbVFSPEs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 11:04:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TGOiorf9ECsQF3lAZspzY1gm4/WCmD18jKizeYcw2gksyGM86tRb6jlQwQKWTxWWA/MgrjT6+3sy10zRLBKBankMJdUzMJUWsxsw+iW/OIh/I87JLuEWLvLIOX9C3T1QnbhRAmsqEAuB4vDaKtvgzzH7/3Z8qv4YTM6gaLxPLzM=
Message-ID: <105c793f0506190804d98d8ac@mail.gmail.com>
Date: Sun, 19 Jun 2005 11:04:48 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: Nick Warne <nick@linicks.net>
Subject: Re: 2.6.12 udev hangs at boot
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200506181806.49627.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506181332.25287.nick@linicks.net> <42B45173.6060209@pobox.com>
	 <200506181806.49627.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for pointing this out.

I also have a Slackware 10 machine here on which I was trying to get
2.6.12 working. I was noticing odd things changing when I switched
between the default (2.4.26) kernel and 2.6.12. 'less' wouldn't work,
my /dev/sd* devices weren't there so I couldn't mount my external hard
disk or cdrom drive, and there was that hang at boot time.

I've since downloaded a new udev and installed it and all above
problems are resolved. I did have to do a 'pkgremove udev", though, to
get the /dev/ devices back. (Except that I did it through pkgtool so
'udev' might not be the right name to give to pkgremove.)

I had even checked the Documentation/Changes file to see if Slackware
10 came with some outdated package, and udev wasn't mentioned. I'm not
sure where else I should have looked for information like that,
though.

Anyway, just a heads-up to anyone else experiencing a breaking of
'less' and missing /dev files.

-Andy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752242AbWJNXhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbWJNXhZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 19:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752247AbWJNXhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 19:37:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49627 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752246AbWJNXhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 19:37:24 -0400
Subject: Re: Driver model.. expel legacy drivers?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Kevin K <k_krieser@sbcglobal.net>, linux-kernel@vger.kernel.org
In-Reply-To: <45315A20.6090600@comcast.net>
References: <4530570B.7030500@comcast.net>
	 <20061014075625.GA30596@stusta.de> <4530FC8E.7020504@comcast.net>
	 <7E4CA247-AD0A-4A20-BEAF-CDD2CA4D3FFE@sbcglobal.net>
	 <45315A20.6090600@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 15 Oct 2006 01:03:57 +0100
Message-Id: <1160870637.5732.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-10-14 am 17:44 -0400, ysgrifennodd John Richard Moser:
> Yeah, a static code coverage analyzer or some sort of code-reducer would
> be nice; these are in general pipe dreams but eh.  Also these are
> compressed bzip2 tarball sizes, not compiled kernel sizes or source tree
> sizes.  I would imagine a 100MB bzip2 would turn into something quite
> large; the major issue is the amount of work it takes to maintain
> something like that.

It's not actually clear that you can sensibly evaluate trends like that
or the maintainability. Take a look at the flamewar the day the kernel
tarball stopped fitting on one floppy disk (1.44MB)

Things ceasing to be maintained and exiting the kernel is a two step
process and there is a lot in the "waiting for someone to rescue it"
stage that probably has no remaining users. At some point nor far away
there is going to be a big flush of drivers when ISA bus is dropped.

Microsoft are also being very helpful. They are making it harder and
harder for people to use drivers not microsoft-signed which in turns
pushes up costs for development and as a result encourages more
standardization of driver interfaces to take place.

Alan


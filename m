Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbSLQX5w>; Tue, 17 Dec 2002 18:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSLQX5w>; Tue, 17 Dec 2002 18:57:52 -0500
Received: from smtp03.web.de ([217.72.192.158]:58118 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S265276AbSLQX5w>;
	Tue, 17 Dec 2002 18:57:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Stephen Lord <lord@sgi.com>
Subject: Re: Compile warnings due to missing __inline__ in fs/xfs/xfs_log.h
Date: Wed, 18 Dec 2002 01:05:40 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1040140891.3dff4a5bcf8f5@rumms.uni-mannheim.de> <1040147719.1368.424.camel@localhost.localdomain>
In-Reply-To: <1040147719.1368.424.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212180105.41255.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, thanks for that info, now I understand...
So I think I better take the warnings ;-)

  Thomas

Am Dienstag, 17. Dezember 2002 18:55 schrieb Stephen Lord:
> On Tue, 2002-12-17 at 10:01, Thomas Schlichter wrote:
> > As the __inline__ directive in front of the _lsn_cmp function is not used
> > with the gcc version 2.95.x, compile-warnings result from many files
> > including this header-file.
>
> The reason inline is turned off for this compiler version is that it
> generates bad code when inlining this code. So you can have a quiet
> compile, or bad code.
>
> Steve


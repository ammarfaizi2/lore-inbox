Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbTHZWUo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 18:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbTHZWUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 18:20:41 -0400
Received: from smtp.mailix.net ([216.148.213.132]:55500 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S262983AbTHZWUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 18:20:36 -0400
Date: Wed, 27 Aug 2003 00:20:32 +0200
From: Alex Riesen <fork0@users.sf.net>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]O18.1int
Message-ID: <20030826222032.GA1055@steel.home>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <200308231555.24530.kernel@kolivas.org> <yw1xr83accpa.fsf@users.sourceforge.net> <20030825094240.GJ16080@Synopsys.COM> <yw1xad9yca8j.fsf@users.sourceforge.net> <3F49E482.7030902@cyberone.com.au> <20030825102933.GA14552@Synopsys.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825102933.GA14552@Synopsys.COM>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen, Mon, Aug 25, 2003 12:29:33 +0200:
> Nick Piggin, Mon, Aug 25, 2003 12:27:14 +0200:
> > If you have some spare time perhaps you could test my scheduler
> > patch.
> 
> i'll try to. Can't promise to have it today, though.
> 

tried 7a. What I noticed first, is that the problem with rxvt eating up
all cpu time is gone :) Also applications get less priorities (11-16).
Can't say everything is very smooth, but somehow it makes very good
impression. No really rough edges, but I have to admit I tried only pure
cpu load (bash -c 'while :; do :; done').
Applications feel to start faster (subjective).
X was/is not niced.

Made the kernel to default boot for now, will see how it behaves.

-alex


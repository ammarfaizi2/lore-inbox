Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289287AbSANX0O>; Mon, 14 Jan 2002 18:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289305AbSANXZg>; Mon, 14 Jan 2002 18:25:36 -0500
Received: from zero.tech9.net ([209.61.188.187]:29189 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289301AbSANXZY>;
	Mon, 14 Jan 2002 18:25:24 -0500
Subject: Re: slowdown with new scheduler.
From: Robert Love <rml@tech9.net>
To: Heinz Diehl <hd@cavy.de>
Cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Banai Zoltan <bazooka@enclavenet.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20020114224034.GA7899@elfie.cavy.de>
In-Reply-To: <20020114202903.8BA9176330@public.kitware.com>
	<20020114211010Z289070-13997+4807@vger.kernel.org> 
	<20020114224034.GA7899@elfie.cavy.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 14 Jan 2002 18:28:32 -0500
Message-Id: <1011050913.4604.97.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-14 at 17:40, Heinz Diehl wrote:

> > After that you should apply preempt+locl-break or LL to both.
> 
> The same here, lock-break does not apply to 2.4.18-pre3+H7 without 
> some failed hunks....

Just a note, if lock-break fails in chunks it is probably OK to just
ignore them.  Each lock-break is independent so, while it is less lock
breaking, it is nearly the same and certainly works fine.

Wouldn't give the same advice for rmap, however.  Best to make sure your
VM applies cleanly :)

	Robert Love


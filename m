Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263391AbTDGMJT (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263392AbTDGMJT (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:09:19 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:2056 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S263391AbTDGMJP (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:09:15 -0400
Date: Mon, 7 Apr 2003 14:19:50 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: 76306.1226@compuserve.com, <linux-kernel@vger.kernel.org>
Subject: Re: Wanted: a limit on kernel log buffer size
In-Reply-To: <33182.4.64.238.61.1049683748.squirrel@webmail.osdl.org>
Message-ID: <Pine.LNX.4.44.0304071416330.12110-100000@serv>
References: <200304062137_MC3-1-3346-A97E@compuserve.com>
 <33182.4.64.238.61.1049683748.squirrel@webmail.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 6 Apr 2003, Randy.Dunlap wrote:

> This is a multi-part answer.  Say, 5 parts.
> 
> a.  If someone won't read the help text, how can we help them?
> 
> b.  If we make a 2 GB log buffer size a compile-time error, will
> they read that?
> 
> c.  If we make it a compile-time warning, will they read that?
> 
> d.  What limit(s) do you suggest?  I can try to add some limits.
> 
> e.  This kind of config limiting should be done in the config system IMO.
> I've asked Roman for that capability....

While I don't mind adding limits, checking it at compile time certainly 
won't hurt.
Even better would be a more dynamic solution, which can release unused 
print buffer after booting.

bye, Roman


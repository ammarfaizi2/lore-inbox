Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262491AbSJETqy>; Sat, 5 Oct 2002 15:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262484AbSJETqy>; Sat, 5 Oct 2002 15:46:54 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:26898
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262491AbSJETqw> convert rfc822-to-8bit; Sat, 5 Oct 2002 15:46:52 -0400
Subject: Re: 2.5.40 (BK of today) vmstat SIGSEGV after reading /proc/stat
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mau <Patrick.Mau@t-online.de>
In-Reply-To: <200210052041.18854.Dieter.Nuetzel@hamburg.de>
References: <200210052041.18854.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 15:53:01 -0400
Message-Id: <1033847582.742.4025.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 14:41, Dieter Nützel wrote:

> 2.5.40/2.5.40-mcp1 gave me same.
> "top" showed only one CPU.
> 
> Solution:
> 
> Get 2.5.40-ac3. Alan "fixed" that.

I think (and I could be wrong, I have been once or twice before) that
what you are describing is separate from the issue I am talking about
and Patrick Mau reported.

In the current BK (not 2.5.40) I believe Linus merged a patch from
Andrew that changed /proc/stat syntax.  This will break old vmstat
binaries.  You need to upgrade to the above version, at least.

	Robert Love



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266953AbTAISdK>; Thu, 9 Jan 2003 13:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266957AbTAISdK>; Thu, 9 Jan 2003 13:33:10 -0500
Received: from [81.2.122.30] ([81.2.122.30]:9479 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266953AbTAISdJ>;
	Thu, 9 Jan 2003 13:33:09 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301091841.h09IfmKS003585@darkstar.example.net>
Subject: Re: Kernel configurator request
To: szepe@pinerecords.com (Tomas Szepe)
Date: Thu, 9 Jan 2003 18:41:48 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030106175443.GP5984@louise.pinerecords.com> from "Tomas Szepe" at Jan 06, 2003 06:54:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.2640.1042137708--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.2640.1042137708--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > Obviously I can work around this, but it would seem to me to be better
> > to have the kernel configurators generate .config files like this:
> > 
> > #
> > # Automatically generated make config: don't edit
> > #
> > 
> > #
> > # Very general options
> > #
> > [Very general options]
> 
> [snip]
> 
> John,
> 
> AFAIK all you have to do to make this reality is add a "comment" clause
> where you need it.

Excellent...

John.

--%--multipart-mixed-boundary-1.2640.1042137708--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: ASCII text
Content-Disposition: attachment; filename="patch"

--- linux-2.5.55-orig/arch/i386/Kconfig	2003-01-09 18:34:19.000000000 +0000
+++ linux-2.5.55/arch/i386/Kconfig	2003-01-09 18:39:34.000000000 +0000
@@ -3,6 +3,8 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
+comment "General options"
+
 mainmenu "Linux Kernel Configuration"
 
 config X86

--%--multipart-mixed-boundary-1.2640.1042137708--%--

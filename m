Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311288AbSCWVxR>; Sat, 23 Mar 2002 16:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311362AbSCWVxG>; Sat, 23 Mar 2002 16:53:06 -0500
Received: from rigljica.arnes.si ([193.2.1.82]:30758 "EHLO rigljica.arnes.si")
	by vger.kernel.org with ESMTP id <S311288AbSCWVw5>;
	Sat, 23 Mar 2002 16:52:57 -0500
Message-ID: <000901c1d2b5$345ce020$41448fd5@telemach.net>
From: "Grega Fajdiga" <Gregor.Fajdiga@arnes.si>
To: "Bob Miller" <rem@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020323125729.7d8fd3fd.Gregor.Fajdiga@telemach.net> <20020323082207.A5636@doc.pdx.osdl.net>
Subject: Re: Compile problems with 2.5.7
Date: Sat, 23 Mar 2002 22:53:43 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day
> Grega,
> 
> Things are a little funny.  You have CONFIG_BSD_PROCESS_ACCT not set
> but the compile errors you're getting are for code in acct.c that
> will only compile if CONFIG_BSD_PROCESS_ACCT is SET.  I suspect that
> something is not right with your view.
> 
> 1. Patch to acct.c didn't work correctly (did you get 2.5.7 by patching
>    or a clean tar?).
> 
> 2. need to do a make mrproper/config/dep/clean/etc...
> 

I downloaded a fresh tar, used the same .config, but got same error.
Regards,
Grega


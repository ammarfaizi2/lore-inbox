Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266940AbSL3Lhq>; Mon, 30 Dec 2002 06:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbSL3Lhq>; Mon, 30 Dec 2002 06:37:46 -0500
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:2296 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id <S266940AbSL3Lhp> convert rfc822-to-8bit; Mon, 30 Dec 2002 06:37:45 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH][COMPAT] Eliminate the rest of the __kernel_..._t32 typedefs 0/7
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFF114A669.0B36519B-ON41256C9F.003F8C51@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 30 Dec 2002 12:43:20 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 30/12/2002 12:45:49
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Stephen,

> S390X specific stuff ...
>
> This is basically the whole compatibility syscall infrastructure.
> Are there parts of this that I can merge directly to Linus?

Yes, just do it. If anything turns out to be wrong I'll fix it in
one of the following releases of 2.5. At the moment the compat stuff
is broken for s390x anyway and we have to look into it in the new year.
You have my blessing for ANY change that moves code from architecture
to common code files. If it doesn't fits 100% we can take care of that
later on.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com



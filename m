Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311614AbSCUNR2>; Thu, 21 Mar 2002 08:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311724AbSCUNRJ>; Thu, 21 Mar 2002 08:17:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11272 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311614AbSCUNRA>; Thu, 21 Mar 2002 08:17:00 -0500
Subject: Re: Linux 2.4.19-pre3-ac1
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Thu, 21 Mar 2002 13:32:11 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        zwane@linux.realnet.co.sz (Zwane Mwaikambo),
        MrChuoi@yahoo.com (MrChuoi),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <20020321051101.GA2673@matchmail.com> from "Mike Fedyk" at Mar 20, 2002 09:11:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16o2fr-0005Ba-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Committed_AS:     2228 kB
>                   ^^^^
> 		 This was down to ~500k before mutt was started.

That looks much better. If you want to do an absolute sanity test build a 
non SMP kernel without SYSVIPC support, but with the accounting validation
turned on (mm/memory.c I believe I stuck it in) and it'll burp in the log
whenever it finds an error in the tally

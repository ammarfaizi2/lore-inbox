Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131007AbQKQTpK>; Fri, 17 Nov 2000 14:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131054AbQKQTpA>; Fri, 17 Nov 2000 14:45:00 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:42509 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131007AbQKQTow>; Fri, 17 Nov 2000 14:44:52 -0500
Message-ID: <3A1582AC.1778C336@timpanogas.org>
Date: Fri, 17 Nov 2000 12:10:36 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Subject: Re: ORACLE and 2.4-test10
In-Reply-To: <E13wqb5-00012V-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> 
> > performance, so we came up with something called direct FS, a separate
> > File System interface just for Oracle.  The SOSD layer inside of Oracle
> 
> Yeah but you see thats ugly
> 
> > In NetWare, directFS was little more than a "raw" interface that
> > bypassed the file cache.  It would be like having an API to a direct
> > physical file system that never cached data in the buffer cache.  In
> 
> Its called O_DIRECT and kiovecs. Its already there. Much more generic than
> an 'oraclefs'

Then they should have what they need.  If they have an SOSD plugin, no
reason 
it shouldn't run.

8)

Jeff

> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

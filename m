Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131533AbRA3VWB>; Tue, 30 Jan 2001 16:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130694AbRA3VVv>; Tue, 30 Jan 2001 16:21:51 -0500
Received: from [63.148.55.4] ([63.148.55.4]:34806 "EHLO
	ninigret.metatel.office") by vger.kernel.org with ESMTP
	id <S131533AbRA3VVi>; Tue, 30 Jan 2001 16:21:38 -0500
Message-ID: <3A77305A.530BAD4D@eDial.com>
Date: Tue, 30 Jan 2001 16:21:30 -0500
From: Rafal Boni <rafal.boni@eDial.com>
Organization: eDial Server Widgets, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: inka-user@lina.inka.de
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre6/7: why can't I dump core?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd wrote thusly:

|In article <200101252341.SAA01008@ninigret.metatel.office> you wrote: 
|> I've done a quick inspection of pre7 patch set and noticed about the 
|> same thing. Is this an oversight, did someone intentionally turn off 
|> core dumping until some other widget is incorporated into the
patches, 
|> or none of the above (a conspiracy, maybe? 8-). 
|
|what is ulimit -c telling you? 

I'm using csh, but limit tells me core size is something like 1Gb.  
In case the shell was confused, I also set coredumpsize to `unlimited', 
but got same result (elf_core_dump bails as  current->dumpable == 0)

Thanks,
--rafal

--
Rafal Boni                                             
rafal.boni@eDial.com
 PGP key C7D3024C, print EA49 160D F5E4 C46A 9E91  524E 11E0 7133 C7D3
024C
    Need to get a hold of me?  http://800.eDial.com/rafal.boni@eDial.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

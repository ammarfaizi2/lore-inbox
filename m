Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbSLFSbp>; Fri, 6 Dec 2002 13:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbSLFSbp>; Fri, 6 Dec 2002 13:31:45 -0500
Received: from magic.adaptec.com ([208.236.45.80]:17616 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S265402AbSLFSbo>; Fri, 6 Dec 2002 13:31:44 -0500
Date: Fri, 06 Dec 2002 11:39:00 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Subject: Re: linux-2.4.20 fails to build with aic7xxx
Message-ID: <423680000.1039199940@aslan.btc.adaptec.com>
In-Reply-To: <200212061730.16703.m.c.p@wolk-project.de>
References: <200212061730.16703.m.c.p@wolk-project.de>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Ralf,
> 
>> yacc -d -b aicasm_gram aicasm_gram.y
>> aicasm_gram.y:921.21: parse error, unexpected ":", expecting ";" or "|"
>> aicasm_gram.y:936.2-5: $$ of critical_section_start' has no declared type
>> aicasm_gram.y:938.2-5: $$ of critical_section_start' has no declared type
>> make[6]: *** [aicasm_gram.h] Error 1
> the fix is imho the easiest fix anyone ever done on earth ;)
> 
> attached!

Actually, there is another missing ';' near the first you caught.  I've
updated my local sources and will release a new driver drop for 2.4.X
today.

--
Justin

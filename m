Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264499AbUD1LW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbUD1LW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 07:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUD1LW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 07:22:29 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:7436 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264499AbUD1LW2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 07:22:28 -0400
Message-ID: <408F9447.2060504@aitel.hist.no>
Date: Wed, 28 Apr 2004 13:23:51 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <20040427165819.GA23961@valve.mbsi.ca> <408E9771.7020302@mtu.edu> <F55B44BB-9870-11D8-85DF-000A95BCAC26@linuxant.com> <408E9C59.2090502@nortelnetworks.com>            <Pine.LNX.4.58.0404271950170.4424@alpha.polcom.net> <200404271854.i3RIsdaP017849@turing-police.cc.vt.edu>
In-Reply-To: <200404271854.i3RIsdaP017849@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Tue, 27 Apr 2004 19:53:39 +0200, Grzegorz Kulewski said:
> 
> 
>>Maybe kernel should display warning only once per given licence or even 
>>once per boot (who needs warning about tainting tainted kernel?)
> 
> 
> If your kernel is tainted by 3 different modules, it saves you 2 reboots when
> trying to replicate a problem with an untainted kernel.
> 
> Other than that, there's probably no reason to complain on a re-taint.
> 
The tainting flag is in each module.  Instead of trying them all
to see what taints the kernel, run "find"
over /etc/modules/<kernelversion>
to find all modules installed, and use some program
that print out the taintedness for each file.  Simple, and
works even for modules that never gets loaded during normal use.

I don't know if such a program exists, but it should be trivial
to make, just paste the kernel "tainting" code into a
ordinary program.

Helge Hafting


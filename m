Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTJaHeK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 02:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTJaHeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 02:34:10 -0500
Received: from [212.55.154.23] ([212.55.154.23]:6042 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S263053AbTJaHeG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 02:34:06 -0500
Message-ID: <3FA21098.6020504@vgertech.com>
Date: Fri, 31 Oct 2003 07:34:48 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031020 Debian/1.5-1
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi is working [was: Post-halloween doc updates.]
References: <20031030141519.GA10700@redhat.com>
In-Reply-To: <20031030141519.GA10700@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!!


Dave Jones wrote:

[...]

> 
> IDE.
> ~~~~

[...]

>   o  ide_scsi is completely broken in 2.6 currently. Known problem.
>      If you need it either use 2.4 or fix it 8)


I have 2.6.0-test9 and I just recorded knoppix to CD with ide-scsi. In 
fact, it never stopped working, in this box, with several 2.6.* kernels.

Hmmmm maybe it's because my cdrecorder is USB?

The box has debian sid and cdrecord is:

puma:/# cdrecord -scanbus
Cdrecord-Clone 2.01a19 (i686-pc-linux-gnu) Copyright (C) 1995-2003 Jörg 
Schilling
Linux sg driver version: 3.5.29
Using libscg version 'schily-0.7'
scsibus2:
         2,0,0   200) 'HP      ' 'CD-Writer cd4f  ' '1.0A' Removable CD-ROM
         2,1,0   201) *
         2,2,0   202) *
         2,3,0   203) *
         2,4,0   204) *
         2,5,0   205) *
         2,6,0   206) *
         2,7,0   207) *
scsibus3:
         3,0,0   300) 'HP      ' 'psc 2210        ' '1.00' Removable Disk
         3,1,0   301) *
         3,2,0   302) *
         3,3,0   303) *
         3,4,0   304) *
         3,5,0   305) *
         3,6,0   306) *
         3,7,0   307) *
puma:/#

Just to be clear: I *can* record cd's! :-)

Can I provide any more info?

Regards,
Nuno Silva



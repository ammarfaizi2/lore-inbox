Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbTCEMjY>; Wed, 5 Mar 2003 07:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbTCEMjY>; Wed, 5 Mar 2003 07:39:24 -0500
Received: from sysdoor.net ([62.212.103.239]:16140 "EHLO celia")
	by vger.kernel.org with ESMTP id <S266718AbTCEMjW>;
	Wed, 5 Mar 2003 07:39:22 -0500
Date: Wed, 5 Mar 2003 13:49:37 +0100
From: Michael Vergoz <mvergoz@sysdoor.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: timothy.a.reed@lmco.com, linux-kernel@vger.kernel.org
Subject: Re: High Mem Options
Message-Id: <20030305134937.5414b913.mvergoz@sysdoor.com>
In-Reply-To: <1046871362.14169.0.camel@irongate.swansea.linux.org.uk>
References: <9EFD49E2FB59D411AABA0008C7E675C00DCDFE01@emss04m10.ems.lmco.com>
	<20030305131116.0556f3a5.mvergoz@sysdoor.com>
	<1046871362.14169.0.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

That i can't understand i when the system going to the protect mode. 
How the system can use over 4GB memory ?
On freebsd, when you have over 4GB the system say "XGB of XGB skiped..."
(i'v got a machine with 8GB running on freebsd and without memory spare)

Best regards,
Michael


On 05 Mar 2003 13:36:02 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Wed, 2003-03-05 at 12:11, Michael Vergoz wrote:
> > Hi Tim,
> > 
> > Every system can NOT manage more than 4GB memory on x86 processor (32 bits processor).
> > Because the system addressing is limited to 32Bits, well memory > 4GB is used generaly for memory spare...
> 
> x86 has 36bit physical addressing, its a truely bonkers implementation
> but it does have the facility. The limt in reality is 3Gb per process
> (1Gb is used for kernel mapping - we could do 4Gb per process but the
> syscall cost would go up a lot).
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

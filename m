Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbTCEMUo>; Wed, 5 Mar 2003 07:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265947AbTCEMUo>; Wed, 5 Mar 2003 07:20:44 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45474
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265791AbTCEMUn>; Wed, 5 Mar 2003 07:20:43 -0500
Subject: Re: High Mem Options
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Vergoz <mvergoz@sysdoor.com>
Cc: "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030305131116.0556f3a5.mvergoz@sysdoor.com>
References: <9EFD49E2FB59D411AABA0008C7E675C00DCDFE01@emss04m10.ems.lmco.com>
	 <20030305131116.0556f3a5.mvergoz@sysdoor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046871362.14169.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 05 Mar 2003 13:36:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-05 at 12:11, Michael Vergoz wrote:
> Hi Tim,
> 
> Every system can NOT manage more than 4GB memory on x86 processor (32 bits processor).
> Because the system addressing is limited to 32Bits, well memory > 4GB is used generaly for memory spare...

x86 has 36bit physical addressing, its a truely bonkers implementation
but it does have the facility. The limt in reality is 3Gb per process
(1Gb is used for kernel mapping - we could do 4Gb per process but the
syscall cost would go up a lot).


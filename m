Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266243AbTCEMYq>; Wed, 5 Mar 2003 07:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265687AbTCEMYp>; Wed, 5 Mar 2003 07:24:45 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46242
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266243AbTCEMYp>; Wed, 5 Mar 2003 07:24:45 -0500
Subject: Re: High Mem Options
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Reed, Timothy A" <timothy.a.reed@lmco.com>
Cc: Linux "Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
In-Reply-To: <9EFD49E2FB59D411AABA0008C7E675C00DCDFE01@emss04m10.ems.lmco.com>
References: <9EFD49E2FB59D411AABA0008C7E675C00DCDFE01@emss04m10.ems.lmco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046871526.14167.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 05 Mar 2003 13:38:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-05 at 11:28, Reed, Timothy A wrote:
> Hello all,
> 	Yet another quick question...is there any down side to using the
> 64GB option over the 4GB option if the machine only has 2GB of RAM onboard??
> I would think this would be a performance issue?  Does the kernel only use
> the translation table if it has to access any memory location over 4GB?

The 64Gb mode has to use different page table formats, so there is a hit
always

-- 
Alan Cox <alan@lxorguk.ukuu.org.uk>

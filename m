Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267120AbTCENGS>; Wed, 5 Mar 2003 08:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267121AbTCENGR>; Wed, 5 Mar 2003 08:06:17 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:163
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267120AbTCENGR>; Wed, 5 Mar 2003 08:06:17 -0500
Subject: Re: High Mem Options
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Vergoz <mvergoz@sysdoor.com>
Cc: timothy.a.reed@lmco.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030305134937.5414b913.mvergoz@sysdoor.com>
References: <9EFD49E2FB59D411AABA0008C7E675C00DCDFE01@emss04m10.ems.lmco.com>
	 <20030305131116.0556f3a5.mvergoz@sysdoor.com>
	 <1046871362.14169.0.camel@irongate.swansea.linux.org.uk>
	 <20030305134937.5414b913.mvergoz@sysdoor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046874070.14169.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 05 Mar 2003 14:21:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-05 at 12:49, Michael Vergoz wrote:
> Hi Alan,
> 
> That i can't understand i when the system going to the protect mode. 
> How the system can use over 4GB memory ?

In PAE mode the later CPUS have 32bit virtual addresses but the page
table entries to map these allow 36bit physical addresses. It means you
can't address more than 4Gb at a time without updating MMU tables

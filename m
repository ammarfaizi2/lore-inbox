Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbTAATrr>; Wed, 1 Jan 2003 14:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbTAATrr>; Wed, 1 Jan 2003 14:47:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55686
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261721AbTAATrq>; Wed, 1 Jan 2003 14:47:46 -0500
Subject: Re: ide-scsi CD-recorder error reading burned disks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Guennadi Liakhovetski <lyakh@mail.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1030101105132.14470B-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030101105132.14470B-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Jan 2003 20:37:44 +0000
Message-Id: <1041453464.21708.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-01 at 15:56, Bill Davidsen wrote:
> On Tue, 31 Dec 2002, Guennadi Liakhovetski wrote:
> 
> This is caused by either the way you burn it, or the inability of cdrecord
> to create a CD which doesn't do this. It's related to read-ahead, but I
> don't remember the exact detail. In any case, you *may* be able to get rid
> of the problem by using -pad in mkisofs, or in cdrecord. 

Sounds like a scsi error handling funny more than anything else. The end
of disk case for cd-r/cd-rw burned disks are a bit fuzzier than normal
disks. The ide-cd layer knows about this.


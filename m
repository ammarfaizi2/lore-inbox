Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319313AbSIGRym>; Sat, 7 Sep 2002 13:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319441AbSIGRym>; Sat, 7 Sep 2002 13:54:42 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:6127 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319313AbSIGRyl>; Sat, 7 Sep 2002 13:54:41 -0400
Subject: Re: ide-scsi oops
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bob McElrath <mcelrath+kernel@draal.physics.wisc.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020907163749.GA5985@draal.physics.wisc.edu>
References: <20020907163749.GA5985@draal.physics.wisc.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 07 Sep 2002 19:01:05 +0100
Message-Id: <1031421665.14390.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-07 at 17:37, Bob McElrath wrote:
> Kernel 2.4.20-pre5-ac4 with the latest ACPI patches gives me an oops any
> time I try to access the CD-ROM:
> 
> Note this also happened with pre4-ac1 so I don't think it's due to the
> latest IDE merge in pre5-ac4.

Yes. What were you doing to trigger it. Also do you have highio/highmem
stuff enabled and is taskfile on or off ?

I'm having real trouble reproducing this problem although enough people
see it thats its clearly quite real


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbUBKLe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 06:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUBKLe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 06:34:26 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:33444 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264283AbUBKLeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 06:34:24 -0500
Subject: Re: ATARAID userspace configuration tool
From: Christophe Saout <christophe@saout.de>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <4029892C.2070009@backtobasicsmgmt.com>
References: <Pine.LNX.4.40.0402101405190.25784-100000@jehova.dsm.dk>
	 <1076425115.23946.18.camel@leto.cs.pocnet.net>
	 <40292246.2030902@backtobasicsmgmt.com>
	 <1076440714.27328.8.camel@leto.cs.pocnet.net>
	 <20040211013551.GB2153@kroah.com>  <4029892C.2070009@backtobasicsmgmt.com>
Content-Type: text/plain
Message-Id: <1076499258.5253.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 11 Feb 2004 12:34:19 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi, den 11.02.2004 schrieb Kevin P. Fleming um 02:45:

> The tricky part is for Thomas' ataraid-detect program to keep some 
> information around when it has seen the first component of a RAID-0 but 
> not the second (or vice-versa). It would be very inefficient to scan all 
> known block devices every time a new one is added, although that 
> brute-force method could be used just to get the program working at 
> first. Once the whole idea has been tested and works properly (the 
> ATARAID devices become available and function properly), the efficiency 
> problem(s) could be addressed.

Aren't the disks the ATARAID is made of usually on the same controller?
Then you only have to scan that one.



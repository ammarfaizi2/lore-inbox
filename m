Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbTFMIvv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 04:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbTFMIvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 04:51:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8368
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265266AbTFMIvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 04:51:48 -0400
Subject: Re: 3ware and two drive hardware raid1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mike Dresser <mdresser_l@windsormachine.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0306121148340.22835-100000@router.windsormachine.com>
References: <Pine.LNX.4.33.0306121148340.22835-100000@router.windsormachine.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055494998.5162.26.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jun 2003 10:03:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-06-12 at 16:56, Mike Dresser wrote:
> If i have a hardware raid1 array of two 120 gig Maxtor DiamondMax 9 drives
> on a 3ware 7000-2.  Failure of one disk should not go all the way up to
> the OS and cause the OS to report hard errors, and remount the drive as
> read-only, right?

Yes, but that won't help you if you lost both drives, which does happen
now and again - overheating, bad PSU, using two drives from the same
batch together and so on.

The trace looks like you may have lost both drives.

Alan


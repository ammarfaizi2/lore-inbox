Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318891AbSHSMOe>; Mon, 19 Aug 2002 08:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318892AbSHSMOd>; Mon, 19 Aug 2002 08:14:33 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:1783 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318891AbSHSMOd>; Mon, 19 Aug 2002 08:14:33 -0400
Subject: Re: 2.4.20-pre3 boot hang
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Markus Plail <plail@web.de>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <87r8gv702r.fsf@plailis.homelinux.net>
References: <20020818153145.GA3184@df1tlpc.local.here>
	<87vg6811p6.fsf@plailis.homelinux.net>
	<1029694978.16822.10.camel@irongate.swansea.linux.org.uk> 
	<87r8gv702r.fsf@plailis.homelinux.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 19 Aug 2002 13:18:45 +0100
Message-Id: <1029759525.19375.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-19 at 08:57, Markus Plail wrote:
> >Oops log, dmesg boot log of 2.4.18 and 2.4.20pre2-ac3 ?
> 
> Here it comes. I tried ac4 this morning and it's still the same.

Ok thanks. That one does tell me something useful. The scsi layer (most
likely ide-scsi itself) passed down a buffer that did not have a valid
mapping.

Do you have Highmem/highio enabled ?



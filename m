Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317078AbSGLUUC>; Fri, 12 Jul 2002 16:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317788AbSGLUUB>; Fri, 12 Jul 2002 16:20:01 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:22010 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317078AbSGLUUB>; Fri, 12 Jul 2002 16:20:01 -0400
Subject: Re: IDE/ATAPI in 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200207122008.g6CK8rTc018445@burner.fokus.gmd.de>
References: <200207122008.g6CK8rTc018445@burner.fokus.gmd.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Jul 2002 22:31:23 +0100
Message-Id: <1026509483.9958.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-12 at 21:08, Joerg Schilling wrote:
> There are enough other OS that use a common ATAPI/SCSI driver concept and
> do not have the problems you vagely name but never really describe.

There are lots that fudge around and pretend scsi is the block layer
when it is not. That sort of misses the point and slows down high end
raid cards.
 
> I believe it's OK to drop support for 10 year old hardware in case this
> is no important hardware that _really_ needs continued support (like
> e.g. 9 track trapes).

We support and people continue to use large amounts of ten year old
hardware. Thats why children at quite a few schools have access to
computing through things like LTSP. There are people actively
maintaining much of this stuff too. 

Some things such as ide tapes which have needs rather different to scsi
tape are still being made and released in newer and larger forms.

> ATA devices that are neither hard disks, nor do support ATAPI decently
> are Y 1992 crap - so unless you like to have continued support for your
> provate museum, what is the reason that you like to prevent a change
> to a more usable driver interface?

You still don't seem to understand the difference between a driver
interface and a hardware layer. 

Alan


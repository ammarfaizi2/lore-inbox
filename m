Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSHAU1J>; Thu, 1 Aug 2002 16:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSHAU1J>; Thu, 1 Aug 2002 16:27:09 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:26353 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317081AbSHAU1J>; Thu, 1 Aug 2002 16:27:09 -0400
Subject: Re: [PATCH] 2.5.29 IDE 110
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <3D499862.6070305@evision.ag>
References: <C917933AE2@vcnet.vc.cvut.cz>  <3D499862.6070305@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 22:47:07 +0100
Message-Id: <1028238427.14871.95.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 21:21, Marcin Dalecki wrote:
> Maybe not a loop device? But how about handling this at partition scan
> time then? Partitions are after all nothing else then devices
> with remapped sectors in first place. Could you manage to insert
> at the proper place in paritions/*.c the magical + 1.
> It could then be turned in no instant in to a global kernel
> option - whch it what it is after all.

Is there any reason this can't be dumped on LVM2 and/or EVMS whichever
gets in ?


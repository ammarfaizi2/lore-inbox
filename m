Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269135AbTGOScV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269414AbTGOScV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:32:21 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55751
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S269135AbTGOScS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:32:18 -0400
Subject: Re: Interrupt doesn't make it to the 8259 on a ASUS P4PE mobo
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Luciano Miguel Ferreira Rocha <luciano@lsd.di.uminho.pt>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F1446E9.8040409@didntduck.org>
References: <PMEMILJKPKGMMELCJCIGOEKNCCAA.kfrazier@mdc-dayton.com>
	 <3F14348B.4050606@didntduck.org> <20030715175909.GA17226@lsd.di.uminho.pt>
	 <3F1446E9.8040409@didntduck.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058294665.3845.61.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jul 2003 19:44:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-15 at 19:24, Brian Gerst wrote:
> Luciano Miguel Ferreira Rocha wrote:
> > On Tue, Jul 15, 2003 at 01:06:19PM -0400, Brian Gerst wrote:
> > 
> >>Use HZ/2 instead.  GCC doesn't optimize floating point constants to the 
> >>same degree it does integers, because it doesn't know what mode 
> >>(rounding, precision) the FPU is in.
> > 
> > 
> > Isn't (HZ >> 1) better?
> 
> Same thing.  GCC knows that division by a power of 2 is just a shift.

Only for unsigned

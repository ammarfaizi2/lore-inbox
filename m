Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSGVP1v>; Mon, 22 Jul 2002 11:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317334AbSGVP1v>; Mon, 22 Jul 2002 11:27:51 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:32761 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316541AbSGVP1v>; Mon, 22 Jul 2002 11:27:51 -0400
Subject: Re: Athlon XP 1800+ segemntation fault
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olivier Galibert <galibert@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020722104919.A3472@zalem.puupuu.org>
References: <20020722133259.A1226@acc69-67.acn.pl> 
	<20020722104919.A3472@zalem.puupuu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 17:43:41 +0100
Message-Id: <1027356221.31782.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 15:49, Olivier Galibert wrote:
> On Mon, Jul 22, 2002 at 01:32:59PM +0000, Karol Olechowskii wrote:
> > Hello 
> > 
> > Few days ago I've bought new processor Athlon XP 1800+ to my computer
> > (MSI K7D Master with 256 MB PC2100 DDR).Before that I've got Athlon ThunderBird
> > 900 processor and everything had been working well till I change to the new one.
> > Now for every few minutes I've got segmetation fault or immediate system reboot.
> > Could anyone tell me what's goin' on?
> 
> mem=nopentium on the command line seems to have a stabilizing effect.

In your case thats the memory handling stuff that the NVidia module
happens to trip. Its actually a kernel related thing not their fault.
There is a horrible work around in 2.4.19-rc2, and people are working on
the right fixes for this.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269851AbRHDSjP>; Sat, 4 Aug 2001 14:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269853AbRHDSjF>; Sat, 4 Aug 2001 14:39:05 -0400
Received: from u-97-19.karlsruhe.ipdial.viaginterkom.de ([62.180.19.97]:2944
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S269851AbRHDSip>; Sat, 4 Aug 2001 14:38:45 -0400
Date: Sat, 4 Aug 2001 18:46:47 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Red Phoenix <redph0enix@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux C2-Style Audit Capability
Message-ID: <20010804184647.A1268@bacchus.dhis.org>
In-Reply-To: <LAW2-F31DgC81TbdkSm00013be0@hotmail.com> <E15Sxf5-0004pT-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15Sxf5-0004pT-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Aug 04, 2001 at 10:23:58AM +0100
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2001 at 10:23:58AM +0100, Alan Cox wrote:

> > System calls are overridden by pointing sys_call_table[system call] to a 
> > replacement function which saves off the data for auditing purposes, then 
> > calls the original system call.
> 
> Ugly but that bit probably ties in with all the other folks trying to put
> together a unified security hook set for 2.5

That approach means you have to write a large number of system specific
wrappers for the various architectures.

  Ralf

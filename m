Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318922AbSHSPvf>; Mon, 19 Aug 2002 11:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318923AbSHSPvf>; Mon, 19 Aug 2002 11:51:35 -0400
Received: from einstein.kowalk.Informatik.Uni-Oldenburg.de ([134.106.55.1]:43139
	"EHLO walker.pmhahn.de") by vger.kernel.org with ESMTP
	id <S318922AbSHSPve>; Mon, 19 Aug 2002 11:51:34 -0400
Date: Mon, 19 Aug 2002 17:54:21 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Interrupt issue with 2.4.19 vs 2.4.18.
Message-ID: <20020819155421.GA10726@titan.lahn.de>
Mail-Followup-To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3D5D527E.5030607@thirddimension.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5D527E.5030607@thirddimension.net>
User-Agent: Mutt/1.4i
Organization: UUCP-Freunde Lahn e.V.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Reid!

On Fri, Aug 16, 2002 at 03:29:02PM -0400, Reid Sutherland wrote:
> I have a problem with the aic7xxx constantly retrying to initialize my 
> LVD SCSI drives.  I'm repeatedly getting a "Command already completed" 
> message.  It was mentioned to me that this might be an interrupt related 
> problem (thank you Justin!).
> 
> My board has a Intel 440GX chipset.  From my understanding these are a 
> bitch to deal with and are littered with bugs.  I've also read that by 
> enabling SMP or IO-APIC, it should solve this issue.  Well, neither does 
> it for me.
> 
> Does anyone know what could have changed between .18 and .19 that would 
> cause something like this to happen?

I had it the other way around: 2.4.18 worked only with "pci=noacpi",
2.4.19 works without the extra boot option. You might check for ACPI
related things and give the pci=... options a try.

(My 2.4.18 was actually 2.4.18+acpi+pciirq)

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

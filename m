Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbREAIrI>; Tue, 1 May 2001 04:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136596AbREAIrA>; Tue, 1 May 2001 04:47:00 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:40064 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131191AbREAIqn>; Tue, 1 May 2001 04:46:43 -0400
Date: Tue, 1 May 2001 10:46:41 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
Message-ID: <20010501104641.C3305@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <CDF99E351003D311A8B0009027457F140810E286@ausxmrr501.us.dell.com> <200104242159.f3OLxoB07000@vindaloo.ras.ucalgary.ca> <p05100313b70bb73ce962@[207.213.214.37]> <200104270431.f3R4V4630593@vindaloo.ras.ucalgary.ca> <p05100303b70eadd613b0@[207.213.214.37]> <200105010127.f411RDP03013@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200105010127.f411RDP03013@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Mon, Apr 30, 2001 at 07:27:13PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 07:27:13PM -0600, Richard Gooch wrote:
> Then, vendors provide their own PCI fixups, which turn /dev/bus/pci0

What about /dev/bus/pci/0 or /dev/bus/pci/pci0 instead?

That way we could hook roots of busses (which are "." nodes, like
if they where mounted independently) better into /dev/bus.

And even implement the thing as a mount point later, if we go the way
Al Viro suggested and have independent "device filesystems"
for the subsystems themselves.

Just an idea...

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>

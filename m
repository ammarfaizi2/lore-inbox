Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264676AbSKEPJJ>; Tue, 5 Nov 2002 10:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263986AbSKEPJJ>; Tue, 5 Nov 2002 10:09:09 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:55262 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S264676AbSKEPJH>; Tue, 5 Nov 2002 10:09:07 -0500
Date: Tue, 5 Nov 2002 16:15:40 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre10-ac2, Sony PCG-C1MHP and Sonypi
Message-ID: <20021105151540.GB12610@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Manuel Serrano <Manuel.Serrano@sophia.inria.fr>,
	linux-kernel@vger.kernel.org
References: <20021105104620.7c1282fa.Manuel.Serrano@sophia.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105104620.7c1282fa.Manuel.Serrano@sophia.inria.fr>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 10:48:29AM +0100, Manuel Serrano wrote:

> Here is the description of my fourth problem with my Sony Picturebook 
> PCG-C1MHP computer. 
> 
> [1.] One line summary of the problem:
> =====================================
> 
> Incompatibility between USB and SONYPI.
> 
> [2.] Full description of the problem/report:
> ============================================
> 
> Sonypi and USB modules seems to be incompatible. That is, if I don't load
> any USB kernel modules, using Sonypi works perfectly (I mostly use it
> to access the LCD brightness). 

Does this mean that you can use it to get jogdial or Fn keys events too ?

> If I load USB modules, then Sonypi reports
> errors:

Please send me (off list)  a copy of your dissassambled ACPI bios(*)
and I'll take a look at it.

Stelian.

(*) get the tools from http://developer.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.gz
    build the tools and run:
    	acpidmp/acpidmp DSDT | acpidisasm/acpidisasm > sony.asl
    and send me the asl file.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com

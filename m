Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289050AbSAIWQV>; Wed, 9 Jan 2002 17:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSAIWQN>; Wed, 9 Jan 2002 17:16:13 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:15365 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S289049AbSAIWPa>; Wed, 9 Jan 2002 17:15:30 -0500
Date: Wed, 9 Jan 2002 23:15:28 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Greg KH <greg@kroah.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        felix-dietlibc@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109231528.B25786@devcon.net>
Mail-Followup-To: Anton Altaparmakov <aia21@cam.ac.uk>,
	Greg KH <greg@kroah.com>,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
	felix-dietlibc@fefe.de, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk> <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk> <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk> <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk> <20020109214022.GE21963@kroah.com> <5.1.0.14.2.20020109215335.02cfc780@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.1.0.14.2.20020109215335.02cfc780@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Wed, Jan 09, 2002 at 09:55:34PM +0000
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 09:55:34PM +0000, Anton Altaparmakov wrote:
> 
> I would think that is a good idea but I am not sure that is what is planned 
> / will happen. Keeping it outside would have the advantage that a newer 
> partition recognizer (or whatever other code) can be applied to any 
> existing kernel version (that supports initramfs).

This could be done anyway: just replace the initramfs image built by 
the kernel build with anotherone built from another source tree. It
would be helpful though if the tools were distributed both standalone
and included into the kernel tree.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net

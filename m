Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287828AbSAIQsq>; Wed, 9 Jan 2002 11:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287850AbSAIQsg>; Wed, 9 Jan 2002 11:48:36 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:11020 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S287828AbSAIQsZ>; Wed, 9 Jan 2002 11:48:25 -0500
Date: Wed, 9 Jan 2002 17:48:17 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Patrick Mochel <mochel@osdl.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
        Greg KH <greg@kroah.com>, felix-dietlibc@fefe.de,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109174817.A24072@devcon.net>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Patrick Mochel <mochel@osdl.org>,
	Anton Altaparmakov <aia21@cam.ac.uk>, Greg KH <greg@kroah.com>,
	felix-dietlibc@fefe.de, linux-kernel@vger.kernel.org
In-Reply-To: <20020109155608.GG21317@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0201090802390.865-100000@segfault.osdlab.org> <20020109162951.GA24175@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020109162951.GA24175@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Wed, Jan 09, 2002 at 05:29:51PM +0100
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 05:29:51PM +0100, Pavel Machek wrote:
> 
> But that means that I'll need partition discovery code twice. Once on
> initrd, and once on my root, because if I insert PCMCIA harddrive on
> runtime, I'll need same detection.

Where is the problem? Generally I think you will have /every/ piece of
code on the initramfs also somewhere on your normal fs, to build the
initramfs image from. Also, who says that you have to abandon your
initramfs after the switch to the real root fs?

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net

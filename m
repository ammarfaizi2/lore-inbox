Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269469AbUI3UC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269469AbUI3UC3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269467AbUI3UAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:00:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64012 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269472AbUI3T73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:59:29 -0400
Date: Thu, 30 Sep 2004 20:59:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?iso-8859-1?Q?Roland_Ca=DFebohm?= 
	<roland.cassebohm@VisionSystems.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial driver hangs
Message-ID: <20040930205922.F5892@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Fulghum <paulkf@microgate.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	=?iso-8859-1?Q?Roland_Ca=DFebohm?= <roland.cassebohm@VisionSystems.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200409281734.38781.roland.cassebohm@visionsystems.de> <200409291607.07493.roland.cassebohm@visionsystems.de> <1096467951.1964.22.camel@deimos.microgate.com> <200409301816.44649.roland.cassebohm@visionsystems.de> <1096571398.1938.112.camel@deimos.microgate.com> <1096569273.19487.46.camel@localhost.localdomain> <1096573912.1938.136.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1096573912.1938.136.camel@deimos.microgate.com>; from paulkf@microgate.com on Thu, Sep 30, 2004 at 02:51:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 02:51:52PM -0500, Paul Fulghum wrote:
> On Thu, 2004-09-30 at 13:34, Alan Cox wrote:
> > This is strictly forbidden and always has been. I've no
> > plan to touch that restriction merely to re-educate 
> > any offender
> 
> Any offender in this case is most serial drivers,
> including the 8520/serial driver in current 2.6

which in turn also means the bug exists in 2.4...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

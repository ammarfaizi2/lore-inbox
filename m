Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263593AbUERIFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbUERIFS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 04:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbUERIFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 04:05:18 -0400
Received: from aelfric.plus.com ([80.229.143.166]:58294 "EHLO zaphod.hmmn.org")
	by vger.kernel.org with ESMTP id S263865AbUERIFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 04:05:09 -0400
Date: Tue, 18 May 2004 09:05:07 +0100
From: Jonathan Sambrook <swsusp@hmmn.org>
To: linux-kernel@vger.kernel.org
Cc: swsusp-devel@lists.sourceforge.net
Subject: [Swsusp-devel] swsusp2 + nVidia
Message-ID: <20040518080507.GA15247@hmmn.org>
References: <200405161425.57745.rpaskowitz@confucius.ca> <1084736118.4172.6.camel@DustPuppy.LNX.RO> <200405170838.40560.hpoley@dds.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405170838.40560.hpoley@dds.nl>
Reply-By: Fri May 21 08:57:27 BST 2004
X-OS: Linux 2.4.23 
X-Message-Flag: http://www.hmmn.org
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:38 on Mon 17/05/04, hpoley@dds.nl masquerading as 'Henk Poley' wrote:
> Op zondag 16 mei 2004 21:35, schreef Dumitru Ciobarcianu:
> > On Sun, 2004-05-16 at 14:25 -0400, Robert Paskowitz wrote:
> > > I am wondering if anyone has been able to successfully suspend/resume
> > > with an nvidia card (using nvidia's binaries), while in X with glx/dri
> > > loaded. I was able to suspend/resume successfully from a tty, but going
> > > back to X froze the machine. Thanks.
> >
> > From my testing it looks like the driver does not properly restore
> > (initialize) the card. And not always the machine is frozen, sometimes I
> > can ssh into it and issue an clean reboot. Sometime even the power
> > button works to issue an shutdown (via ACPI).
> 
> My nVidia card doesn't work either. A GeForce4 MX440, with current nVidia 
> binary drivers. I currently use the open source 'nv' driver, but it's *slow*. 
> (or at least, my system feels less responsive, and I think it has to do with 
> the from time to time 10-20% CPU eating X)


Out of interest: is there anyone from nVidia monitoring the swsusp2
list and thus aware of the issues in their driver requiring
attention?

Regards,
Jonathan

-- 


    .__
    |..|__   _____   _____   ___        ____  _    ____
    |;;|: \ /;:;:;\ /;:;:;\ /;:;\      /;;;;\/;\/\/;;;;\
    |   Y  \  Y Y  \  Y Y  \  Y  \    |  ___ \ |\_| ___ \
    |___|  /__|_|  /__|_|  /__|  /  o  \_____/ |  \___  /
         \/      \/      \/    \/            \/    _/  /
                                                   \__/
 
 hmmnsoft's FreeShade : window shading, for Windows, for free
 
                http://www.hmmn.org/FreeShade


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSGNNIL>; Sun, 14 Jul 2002 09:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSGNNIK>; Sun, 14 Jul 2002 09:08:10 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:62003 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S316500AbSGNNIJ>; Sun, 14 Jul 2002 09:08:09 -0400
Date: Sun, 14 Jul 2002 15:09:12 +0200
From: Dominik Brodowski <devel@brodo.de>
To: petero2@telia.com, zwane@linuxpower.ca
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac3
Message-ID: <20020714150912.A1148@brodo.de>
References: <1026611437.13885.37.camel@irongate.swansea.linux.org.uk> <m265zj9zxn.fsf@best.localdomain> <6010.1026651788@www53.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <6010.1026651788@www53.gmx.net>; from alan@lxorguk.ukuu.org.uk on Sun, Jul 14, 2002 at 03:03:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 03:03:08PM +0200, Alan Cox wrote:
> > 3. The cpu voltage is automatically reduced when the frequency is
> >    reduced.
> 
> True for some x86 processors, either automatically, or on some
> controlled by us.

The p4-clockmod driver you seem to using does not scale the voltage. 
In case you own a P4-M and a ICH2-M or ICH3-M southbridge: the 
speedstep.c driver in the 2.5.-cpufreq patchset (backport to 2.4. 
will be available soon) should do the job and adjust the processor 
voltage.

Dominik


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161154AbWJUAQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbWJUAQn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWJUAQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:16:43 -0400
Received: from mail.suse.de ([195.135.220.2]:10889 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S2992747AbWJUAQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:16:42 -0400
To: artusemrys@sbcglobal.net
Cc: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@linux.ie>, Greg KH <greg@kroah.com>, akpm@osdl.org
Subject: Re: 2.6.19-rc2-mm2
References: <20061020015641.b4ed72e5.akpm@osdl.org>
	<200610201339.49190.m.kozlowski@tuxland.pl>
	<20061020091901.71a473e9.akpm@osdl.org>
	<200610201854.43893.m.kozlowski@tuxland.pl>
	<20061020102520.67b8c2ab.akpm@osdl.org>
	<45394F97.9010401@sbcglobal.net>
From: Andi Kleen <ak@suse.de>
Date: 21 Oct 2006 02:16:28 +0200
In-Reply-To: <45394F97.9010401@sbcglobal.net>
Message-ID: <p734ptybk0z.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Frost <artusemrys@sbcglobal.net> writes:

> Andrew Morton wrote:
> 
> > Ow.  Multithreaded probing was probably a bt ambitious, given the current
> > status of kernel startup..
> > 
> > Greg, does it actually speed anything up or anything else good?
> > 
> 
> I'm on a x86 (P4) hi-mem machine, plenty of onboard PCI (audio, LAN, bonus IDE
> controller, etc.), and it has sped up my boot process.  Between the USB and PCI
> multithread probing, my dmesg is a bit out of order from its ordinary sequence,
> but the only things that stall it now are my MD-RAID partitions getting set up.

Did you measure it?  Feelings and impressions tend to be unreliable.

-Andi

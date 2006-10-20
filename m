Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992613AbWJTWgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992613AbWJTWgs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 18:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992708AbWJTWgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 18:36:48 -0400
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:32869 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S2992613AbWJTWgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 18:36:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=Received:Message-ID:Date:From:Reply-To:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fxJpqOlbtrYL/hSVvAkMUEzC0akK9vyk2GMisHyT6rl1xrCPgF1UlvPoGZ2SKkZiND6sia7zjqwWQSmDVbgu0vJ4vp0LfeVwgF/jKH2RkoJL3YteDrXt847+rHFWWB9zqUwyB2Rxk2F1ojZ6Ddppw7JNFTLcQkCCXuPUE6k4G+4=  ;
Message-ID: <45394F97.9010401@sbcglobal.net>
Date: Fri, 20 Oct 2006 17:37:11 -0500
From: Matthew Frost <artusemrys@sbcglobal.net>
Reply-To: artusemrys@sbcglobal.net
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@linux.ie>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.19-rc2-mm2
References: <20061020015641.b4ed72e5.akpm@osdl.org>	<200610201339.49190.m.kozlowski@tuxland.pl>	<20061020091901.71a473e9.akpm@osdl.org>	<200610201854.43893.m.kozlowski@tuxland.pl> <20061020102520.67b8c2ab.akpm@osdl.org>
In-Reply-To: <20061020102520.67b8c2ab.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Ow.  Multithreaded probing was probably a bt ambitious, given the current
> status of kernel startup..
> 
> Greg, does it actually speed anything up or anything else good?
> 

I'm on a x86 (P4) hi-mem machine, plenty of onboard PCI (audio, LAN, bonus IDE
controller, etc.), and it has sped up my boot process.  Between the USB and PCI
multithread probing, my dmesg is a bit out of order from its ordinary sequence,
but the only things that stall it now are my MD-RAID partitions getting set up.

As far as my mileage, it does speed up performance, but I'm bog-standard and
boring as far as x86 hardware goes.  Obviously, not for everybody.

Thanks!
Matt Frost

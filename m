Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbWFOOIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWFOOIz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 10:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWFOOIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 10:08:53 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:25802
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751431AbWFOOIu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 10:08:50 -0400
From: Michael Buesch <mb@bu3sch.de>
To: andreas@rittershofer.de
Subject: Re: bcm43xx in 2.6.17-rc6
Date: Thu, 15 Jun 2006 16:08:21 +0200
User-Agent: KMail/1.9.1
References: <1150130676.3820.26.camel@coredump> <200606121849.12542.mb@bu3sch.de> <1150281975.4006.6.camel@coredump>
In-Reply-To: <1150281975.4006.6.camel@coredump>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606151608.21705.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 June 2006 12:46, Andreas Rittershofer wrote:
> Am Montag, den 12.06.2006, 18:49 +0200 schrieb Michael Buesch:
> > On Monday 12 June 2006 18:44, Andreas Rittershofer wrote:
> > > 00:0c.0 Network controller: Broadcom Corporation BCM4303 802.11b
> > > Wireless LAN Controller (rev 02)
> > 
> > bcm43xx is hardly tested on B-only hardware.
> > Does it work without encryption?
> > 
> 
> I don't know since I cannot deactivate encryption on my AP - I must use
> encryption.

Why can't you deactivate it for the sake of testing?

> I just tested the following Card-Bus-Card:
> 02:00.0 Network controller: Broadcom Corporation BCM4318 [AirForce One
> 54g] 802.11g Wireless LAN Controller (rev 02)
> 
> It's also a broadcom-chip in another version, but the driver also says:
> ioctl[SIOCSIWENCODEEXT]: Invalid argument
> Driver did not support SIOCSIWENCODEEXT
> WPA: Failed to set PTK to the driver.
> 
> The driver really seems to have a problem: wpa_supplicant wants to do
> something and the driver does not understands it.
> 
> 
> mfg ar

-- 
Greetings Michael.

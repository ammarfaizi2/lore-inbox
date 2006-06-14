Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWFNKqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWFNKqo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 06:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWFNKqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 06:46:44 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:64441 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932280AbWFNKqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 06:46:43 -0400
Subject: Re: bcm43xx in 2.6.17-rc6
From: Andreas Rittershofer <andreas@rittershofer.de>
Reply-To: andreas@rittershofer.de
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606121849.12542.mb@bu3sch.de>
References: <1150130676.3820.26.camel@coredump>
	 <200606121849.12542.mb@bu3sch.de>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 12:46:15 +0200
Message-Id: <1150281975.4006.6.camel@coredump>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-ID: Xdk8n6ZGQedZsVV1PstiXQ6pY+UX6x7FpQFDZ8yDEI45xsga9onxsW@t-dialin.net
X-TOI-MSGID: 451aece3-6609-48da-9281-1dcaef1fc11b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 12.06.2006, 18:49 +0200 schrieb Michael Buesch:
> On Monday 12 June 2006 18:44, Andreas Rittershofer wrote:
> > 00:0c.0 Network controller: Broadcom Corporation BCM4303 802.11b
> > Wireless LAN Controller (rev 02)
> 
> bcm43xx is hardly tested on B-only hardware.
> Does it work without encryption?
> 

I don't know since I cannot deactivate encryption on my AP - I must use
encryption.

I just tested the following Card-Bus-Card:
02:00.0 Network controller: Broadcom Corporation BCM4318 [AirForce One
54g] 802.11g Wireless LAN Controller (rev 02)

It's also a broadcom-chip in another version, but the driver also says:
ioctl[SIOCSIWENCODEEXT]: Invalid argument
Driver did not support SIOCSIWENCODEEXT
WPA: Failed to set PTK to the driver.

The driver really seems to have a problem: wpa_supplicant wants to do
something and the driver does not understands it.


mfg ar
-- 
E-Learning in der Schule:
http://www.dbg-metzingen.de/Menschen/Lehrer/Q-T/Rittershofer/E-Learning/


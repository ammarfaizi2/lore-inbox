Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267509AbUGaORF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267509AbUGaORF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 10:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUGaORE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 10:17:04 -0400
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:38337 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S267955AbUGaOQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 10:16:35 -0400
Date: Sat, 31 Jul 2004 16:14:53 +0200
From: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Re: EHCI / pci power state / suspend annoying interactions
In-reply-to: <20040731121944.GA47191@dspnet.fr.eu.org>
To: Olivier Galibert <galibert@pobox.com>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Message-id: <200407311614.55653@zodiac.zodiac.dnsalias.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
X-Ignorant-User: yes
References: <20040731121944.GA47191@dspnet.fr.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 31. Juli 2004 14:19 schrieb Olivier Galibert:
> The EHCI on the latitude x300 does not have D2 capability:

> That fails suspend-to-ram because dev->suspend which is
> usb_hcd_pci_suspend calls pci_set_power_state to request level D2,
> which fails with -EIO.  The error is propagated back and the suspend
> aborts.  What should actually happen in that case?

This is a known problem. The guys are working on a fix.

regards
Alex

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291


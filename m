Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUANR7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 12:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUANR7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 12:59:44 -0500
Received: from mail-4.tiscali.it ([195.130.225.150]:7064 "EHLO
	mail-4.tiscali.it") by vger.kernel.org with ESMTP id S262050AbUANR7n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 12:59:43 -0500
Date: Wed, 14 Jan 2004 18:59:36 +0100
Message-ID: <3FE5F1110002D60F@mail-4.tiscali.it>
In-Reply-To: <20040114165056.GD13899@picchio.gall.it>
From: m.andreolini@tiscali.it
Subject: Re: problems with suspend-to-disk (ACPI), 2.6.1-rc2
To: "Daniele Venzano" <webvenza@libero.it>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is quite strange because for me the card 
works on resume, I
have the driver compiled in, but that should make no difference.

Could you try to plug/unplug the cable and see if it detects media
changes ? Messages like "Media link on/off" should appear.


I have verified this, but no msg is displayed. If I reload the sis900 module
manually,
it starts logging those

Media Link Off
Media Link On 100mbps full-duplex

messages whenever I unplug/plug the network cable.


Also, since probably the problem is
that the mac filter is not reset
correctly, could you try tcpdump and see if in promiscous mode it
receives something ?


I can't even 'tcpdump eth0' since the eth0 interface is not brought up correctly
on resume:
ifconfig yields only the loopback entry.

Bye
Mauro Andreolini

__________________________________________________________________
Tiscali ADSL SENZA CANONE:
Attivazione GRATIS, contributo adesione GRATIS, modem GRATIS,
50 ore di navigazione GRATIS.  ABBONARTI TI COSTA SOLO UN CLICK!
http://point.tiscali.it/adsl/index.shtml




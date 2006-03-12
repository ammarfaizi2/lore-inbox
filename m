Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWCLUso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWCLUso (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 15:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWCLUso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 15:48:44 -0500
Received: from [81.2.110.250] ([81.2.110.250]:18311 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932191AbWCLUso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 15:48:44 -0500
Subject: RE: Router stops routing after changing MAC Address
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg Scott <GregScott@InfraSupportEtc.com>
Cc: linux-kernel@vger.kernel.org, Bart Samwel <bart@samwel.tk>
In-Reply-To: <925A849792280C4E80C5461017A4B8A20321E0@mail733.InfraSupportEtc.com>
References: <925A849792280C4E80C5461017A4B8A20321E0@mail733.InfraSupportEtc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Mar 2006 20:54:35 +0000
Message-Id: <1142196875.20056.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-03-12 at 13:38 -0600, Greg Scott wrote:
> I think the NICs on all the systems are 3c905b's.  The system with the
> 2.4 kernel on it has them and I think that is what I put in my 2.6-11
> test system as well.  My 2.6 system doesn't have a modules.conf file so
> I will need to dig a little deeper.  I suppose I could just open it up
> and look.  But I am almost sure I put 3c905b cards in both test systems.

Humm - do they start routing correctly if you "ifconfig eth0
promisc" (where eth0 is each interface whose mac you changed) ?


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTFQJPJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 05:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTFQJPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 05:15:08 -0400
Received: from [213.196.40.44] ([213.196.40.44]:39909 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id S261300AbTFQJPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 05:15:06 -0400
Date: Tue, 17 Jun 2003 11:29:00 +0200 (CEST)
From: bvermeul@blackstar.nl
To: linux-kernel@vger.kernel.org
Subject: Problems with PCMCIA/Orinoco
Message-ID: <Pine.LNX.4.44.0306171123540.1854-100000@blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having some problems with 2.5.71 (latest bk yesterday I believe).
All works well (pcmcia works as advertised, with one tiny blip on
the horizon), except when I want to reboot, when I get the following
message:

unregister_netdevice: waiting for eth1 to become free. Usage count = 1

The net device is an Orinoco mini-pci card (eg, cardbus minipci interface 
with built-in orinoco card), and it is down.

I'm not sure what causes this, and it's started somewhere in 2.5.70 bk.

Hope this report helps,

Bas Vermeulen


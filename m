Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbTEGUNC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 16:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbTEGUMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 16:12:44 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6877 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264294AbTEGULy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 16:11:54 -0400
Date: Wed, 7 May 2003 17:22:35 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Undo aic7xxx changes 
Message-ID: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've undone aic7xxx changes which were locking up some machines on
initialization.

The new driver is now named drivers/scsi/aic79xx and is under
CONFIG_AIC79XX.

Justin, unfortunately I can't even THINK about updating aic7xxx to your
new driver at the current release stage. I will do so in the 2.4.22.

The update also contains a PCI posting flush fix from Arjan.

People, please test the driver.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWFNMZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWFNMZy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 08:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWFNMZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 08:25:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23771 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751200AbWFNMZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 08:25:54 -0400
Subject: Re: PATA: UDMA settings in Alans patch-2.6.17-rc4-ide1.gz better
	than with 2.6.17-rc6-mm2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arne Ahrend <aahrend@web.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060612194346.d92fbb05.aahrend@web.de>
References: <20060612194346.d92fbb05.aahrend@web.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Jun 2006 13:42:11 +0100
Message-Id: <1150288931.3490.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the report. This is expected at the moment. The current core
code picks speeds once per interface and keeps master/slave at the same
speed. My patches fix that but before it can go mainstream I need to get
the driver patches in and be sure no existing driver will break when I
do it.

Alan


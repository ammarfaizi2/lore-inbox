Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263563AbTDGRko (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 13:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbTDGRko (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 13:40:44 -0400
Received: from fmr02.intel.com ([192.55.52.25]:14042 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263563AbTDGRko (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 13:40:44 -0400
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010107D3CA@orsmsx402.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: Teodor Iacob <Teodor.Iacob@astral.ro>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Bug Intel e100 driver 2.4.20-8 redhat 9
Date: Mon, 7 Apr 2003 10:51:45 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I load the e100 driver with the UTP cable plugged into 
> the adapter I get the following:
> 
> Intel(R) PRO/100 Network Driver - version 2.1.29-k2
> Copyright (c) 2002 Intel Corporation
> 
> e100: selftest OK.
> e100: hw init failed
> e100: Failed to initialize, instance #0
>
> The machine is an Intel SCB2 with e100 on-board.

Try the latest e100,v2.2.21 driver from sf.net/projects/e1000.

This driver includes a TCO workaround for 82559 wired to the SMBus.

This workaround didn't make it into the RH 9.0 e100 driver.

-scott

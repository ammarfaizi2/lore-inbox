Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWIKJ6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWIKJ6B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 05:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWIKJ6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 05:58:01 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:43930 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S1751317AbWIKJ6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 05:58:00 -0400
Date: Mon, 11 Sep 2006 11:57:59 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org
Subject: missing request_region in pnpbios_probe_system
Message-ID: <20060911095759.GA23339@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does anyone know why pnpbios_probe_system() does no request_region()
before it reads from 0xf0000 to 0xffff0?


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbUAZTcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 14:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUAZTcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 14:32:06 -0500
Received: from post.tau.ac.il ([132.66.16.11]:57277 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S264608AbUAZTbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 14:31:49 -0500
Date: Mon, 26 Jan 2004 21:31:44 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: lkml <linux-kernel@vger.kernel.org>
Subject: PNP depends on ISA ? (2.6.2-rc2
Message-ID: <20040126193144.GC2004@luna.mooo.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.2; VDF: 6.23.0.45; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering why pnp depends on isa being selected in 2.6.2-rc2, is
pnp really only relevant to isa? What happens with pci etc. ?
This may explain why using pnpbios locks up my machine (at least as of 2.6.0-test9).

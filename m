Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266457AbUIIRha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUIIRha (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUIIRhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:37:22 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:8672 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266465AbUIIRZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:25:44 -0400
Date: Thu, 9 Sep 2004 13:30:14 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Germano Barreiro <germano.barreiro@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: including Cyclades pc400 board support
In-Reply-To: <1094750272.3348.4.camel@germano.cyclades.com>
Message-ID: <Pine.LNX.4.53.0409091329270.15087@montezuma.fsmlabs.com>
References: <1094750272.3348.4.camel@germano.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sep 2004, Germano Barreiro wrote:

> This patch includes support in the kernel for pc400 Cyclades board,
> which is the only Cyclades board that doesn't have the driver in the
> official kernel tree yet, and is intended for review. 

You appear to be missing pc400.c

 Documentation/devices.txt      |   10 ++++++++++
 Documentation/magic-number.txt |    1 +
 drivers/char/Kconfig           |   24 ++++++++++++++++++++++++
 drivers/char/Makefile          |    1 +
 include/linux/major.h          |    3 +++
 include/linux/pci_ids.h        |    1 +
 6 files changed, 40 insertions(+)

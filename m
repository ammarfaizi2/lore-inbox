Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbTIJMBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 08:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTIJMBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 08:01:32 -0400
Received: from kde.informatik.uni-kl.de ([131.246.103.200]:63162 "EHLO
	dot.kde.org") by vger.kernel.org with ESMTP id S262641AbTIJMBb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 08:01:31 -0400
Date: Wed, 10 Sep 2003 13:45:57 +0200 (CEST)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: lkml <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net,
       linux-acpi@intel.com
Subject: Re: [PATCH] 2.4.23-pre3 ACPI fixes series (1/3)
In-Reply-To: <200309060115.24340.adq_dvb@lidskialf.net>
Message-ID: <Pine.LNX.4.56.0309101344420.20323@dot.kde.org>
References: <200309051958.02818.adq_dvb@lidskialf.net>
 <200309060016.16545.adq_dvb@lidskialf.net> <3F590E28.6090101@pobox.com>
 <200309060115.24340.adq_dvb@lidskialf.net>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Sep 2003, Andrew de Quincey wrote:

> This patch allows ACPI to drop back to PIC mode if ACPI mode setup fails.

Works nicely here, but causes an oops on startup if you specify acpi=off 
on the command line.

LLaP
bero

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265741AbTIJV2o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265745AbTIJV2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:28:44 -0400
Received: from lidskialf.net ([62.3.233.115]:8668 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S265741AbTIJV2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:28:42 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: Re: [PATCH] 2.4.23-pre3 ACPI fixes series (1/3)
Date: Wed, 10 Sep 2003 22:27:09 +0100
User-Agent: KMail/1.5.3
Cc: lkml <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net,
       linux-acpi@intel.com
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060115.24340.adq_dvb@lidskialf.net> <Pine.LNX.4.56.0309101344420.20323@dot.kde.org>
In-Reply-To: <Pine.LNX.4.56.0309101344420.20323@dot.kde.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309102227.09096.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 Sep 2003 12:45 pm, Bernhard Rosenkraenzer wrote:
> On Sat, 6 Sep 2003, Andrew de Quincey wrote:
> > This patch allows ACPI to drop back to PIC mode if ACPI mode setup fails.
>
> Works nicely here, but causes an oops on startup if you specify acpi=off
> on the command line.

Thanks for reporting that. Andi Kleen beat to me patching it.. He posted it to 
LKML and acpi-devel a day or so ago.. 


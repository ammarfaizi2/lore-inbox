Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbTENMKd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTENMKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:10:32 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25760
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261927AbTENMKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:10:32 -0400
Subject: Re: 2.5.69 panic in ide_dma_intr on Via KT400
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Berg <chuck@encinc.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030514005607.A17701@timetrax.localdomain>
References: <20030514005607.A17701@timetrax.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052911495.2103.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 May 2003 12:24:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-05-14 at 05:56, Chuck Berg wrote:
> I have a machine with a Soyo Dragon motherboard (Via KT400 chipset) that
> when booting 2.5.69 panics while detecting the ide drives. First I get
> "hde: lost interrupt" and after a few more errors, a panic.

Disable ACPI

(The oops is a bug in the error handling in 2.5.x it seems but the
original cause is probably ACPI)


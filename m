Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWARJFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWARJFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 04:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWARJFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 04:05:43 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57989 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030210AbWARJFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 04:05:42 -0500
Subject: Re: [PATCH 000 of 5] md: Introduction
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sander@humilis.net
Cc: Michael Tokarev <mjt@tls.msk.ru>, Ross Vandegrift <ross@jose.lug.udel.edu>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060118081407.GC18945@localhost.localdomain>
References: <20060117174531.27739.patches@notabene>
	 <43CCA80B.4020603@tls.msk.ru>
	 <20060117095019.GA27262@localhost.localdomain>
	 <43CCD453.9070900@tls.msk.ru> <20060117160829.GA16606@lug.udel.edu>
	 <43CD3388.9050107@tls.msk.ru>
	 <20060118081407.GC18945@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Jan 2006 09:03:22 +0000
Message-Id: <1137575002.25819.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-01-18 at 09:14 +0100, Sander wrote:
> If the (harddisk internal) remap succeeded, the OS doesn't see the bad
> sector at all I believe.

True for ATA, in the SCSI case you may be told about the remap having
occurred but its a "by the way" type message not an error proper.

> If you (the OS) do see a bad sector, the disk couldn't remap, and goes
> downhill from there, right?

If a hot spare is configured it will be dropped into the configuration
at that point.


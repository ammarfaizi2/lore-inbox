Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267682AbUHPPMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267682AbUHPPMu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267690AbUHPPMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:12:50 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:48096 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267682AbUHPPIg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:08:36 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: header updates for IDE changes
Date: Mon, 16 Aug 2004 17:08:04 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040815145515.GA9993@devserv.devel.redhat.com>
In-Reply-To: <20040815145515.GA9993@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408161708.04376.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These changes belong to the patches making actual use of them...

BTW What is the ordering in which your patches should be applied?

On Sunday 15 August 2004 16:55, Alan Cox wrote:
> Add a "key" (generation) field to the ide taks object so that we can fix
> the crash when you unload a pcmcia ide device (and later other pci hotplug
> devices etc) while having a proc file accessed
>
> Add a remove function to be called on unload by later patches
> Add a raw_taskfile function to allow drives to do command filters
> Add configured bit so that we can differentiate currently ambigious
> interface states when unloading.
> Add a prototype for ide_diag_taskfile (for raw_taskfile users)
> Add prototypes for the ide key functions (code changes in next patch)

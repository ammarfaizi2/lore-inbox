Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWC3AbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWC3AbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWC3AbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:31:04 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:42733 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751298AbWC3AbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:31:02 -0500
Message-ID: <442B26C4.4090205@pobox.com>
Date: Wed, 29 Mar 2006 19:31:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH: libata. BMDMA handling updates
References: <1143481360.4970.49.camel@localhost.localdomain>
In-Reply-To: <1143481360.4970.49.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.6 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.6 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> This is the minimal patch set to enable the current code to be used with
> a controller following SFF (ie any PATA and early SATA controllers)
> safely without crashes if there is no BMDMA area or if BMDMA is not
> assigned by the BIOS for some reason.
> 
> Simplex status is recorded but not acted upon in this change, this isn't
> a problem with the current drivers as none of them are for simplex
> hardware. A following diff will deal with that.
> 
> The flags in the probe structure remain ->host_set_flags although Jeff
> asked me to rename them, simply because the rename would break the usual
> Linux rules that old code should break when there are changes. not
> compile and run and then blow up/eat your computer/etc. Renaming this
> later is a trivial exercise once a better name is chosen.

applied



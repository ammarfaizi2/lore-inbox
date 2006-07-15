Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945927AbWGOAVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945927AbWGOAVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945934AbWGOAVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:21:36 -0400
Received: from rtr.ca ([64.26.128.89]:18155 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1945927AbWGOAVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:21:36 -0400
Message-ID: <44B8350E.9070409@rtr.ca>
Date: Fri, 14 Jul 2006 20:21:34 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: FYI: strange libata EH lines in dmesg once after every bootup
References: <20060714230801.GA6645@zeus.uziel.local>
In-Reply-To: <20060714230801.GA6645@zeus.uziel.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Trefzer wrote:
> Hi,
> 
> the following happens every time after bootup, tested with freshly built
> 2.6.18-rc1-mm2: 
..
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
> ata1: EH complete
..

Those are S.M.A.R.T. commands.

Either your drive does not support S.M.A.R.T.,
or you have not enabled it it with smartctl

-ml

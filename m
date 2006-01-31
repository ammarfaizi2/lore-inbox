Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWAaPbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWAaPbJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWAaPbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:31:09 -0500
Received: from [85.8.13.51] ([85.8.13.51]:55010 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750959AbWAaPbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:31:08 -0500
Message-ID: <43DF82BF.50308@drzeus.cx>
Date: Tue, 31 Jan 2006 16:31:11 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060128)
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>
CC: linux-kernel@vger.kernel.org,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 5/5] MMC OMAP driver
References: <43DF688E.7020805@indt.org.br>
In-Reply-To: <43DF688E.7020805@indt.org.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Briglia wrote:
> +			if (R1_CURRENT_STATE(cmd.resp[0]) == 7)

Please use a define so I don't have to reach for a MMC spec when reading
this.

Rgds
Pierre


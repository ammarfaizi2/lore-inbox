Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271701AbTHDKtm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 06:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271702AbTHDKtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 06:49:42 -0400
Received: from [217.157.19.70] ([217.157.19.70]:33285 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S271701AbTHDKtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 06:49:41 -0400
Date: Mon, 4 Aug 2003 12:49:39 +0200 (CEST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (2.4.2x) Driver for Medley software RAID (Silicon Image
 3112 SATARaid, CMD680, etc?) for testing
In-Reply-To: <3F2BD6E2.9070101@pobox.com>
Message-ID: <Pine.LNX.4.40.0308041242030.22732-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Sat, 2 Aug 2003, Jeff Garzik wrote:

> Did I miss your response to Arjan's question?

Yes you must have (I replied off-list by mistake and then forwarded to the
list afterwards).

> Since your patch removes "silraid" driver, that introduces user
> transition problems and potential breakage for working users.
>
> So, why did you replace silraid.c?  Linux kernel development prefers
> "evolution" (changing existing code over time) to "revolution"
> (continually rewriting everything).

I was under the impression that silraid.c never worked at all (it
certainly didn't on my system), because the magic number it looks for is
incorrect (actually, part of the drive's serial number), and thus not
present on all systems with this RAID).

I have since found out that some people have been using Arjan's driver
with success, so my final version of the patch will certainly leave it in
so people can migrate to the new driver at their own pace.

Regards,

Thomas


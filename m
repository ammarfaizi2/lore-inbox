Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTL2FRA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 00:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTL2FRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 00:17:00 -0500
Received: from hibernia.jakma.org ([213.79.33.168]:56211 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262707AbTL2FQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 00:16:59 -0500
Date: Mon, 29 Dec 2003 05:16:57 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: chmod of active swap file blocks
In-Reply-To: <Pine.LNX.4.56.0312290434360.2270@fogarty.jakma.org>
Message-ID: <Pine.LNX.4.56.0312290513540.2270@fogarty.jakma.org>
References: <Pine.LNX.4.56.0312290434360.2270@fogarty.jakma.org>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003, Paul Jakma wrote:

> Hi,
> 
> Trying to chmod a file being used for swap causes chmod() to block,
> with permissions change /not/ having taken effect, until the swap
> file is swapoff'd, at which point chmod() carries on and chmod (the
> command) finishes.

err.. forgot kernel version: this occurs with Arjan's 
2.6.0-0.test11.1.100 and .102 RPM packages of the 2.6.0 kernel. I 
have not tried on a generic 2.6.0 kernel, though I am about to try 
Arjan's 2.6.0-1.104 package.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
Bell Labs Unix -- Reach out and grep someone.

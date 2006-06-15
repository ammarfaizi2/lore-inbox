Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWFOQ73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWFOQ73 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 12:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWFOQ73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 12:59:29 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:22414 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932184AbWFOQ72
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 12:59:28 -0400
Message-ID: <449191EE.2090309@drzeus.cx>
Date: Thu, 15 Jun 2006 18:59:26 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: sdhci-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
Subject: Re: [Sdhci-devel] PATCH: Fix 32bitism in SDHCI
References: <1150385605.3490.85.camel@localhost.localdomain>
In-Reply-To: <1150385605.3490.85.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> The data field is ulong, pointers fit in ulongs. Casting them to int is
> bad for 64bit systems.

It's in my (rather large) queue. I'm just waiting for a merge window. :)


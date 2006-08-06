Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWHFXll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWHFXll (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 19:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWHFXll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 19:41:41 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:5766 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750771AbWHFXlk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 19:41:40 -0400
Message-ID: <44D67E3A.9070409@drzeus.cx>
Date: Mon, 07 Aug 2006 01:41:46 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Another stray 'io' reference
References: <20060806234001.11770.63270.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060806234001.11770.63270.stgit@poseidon.drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Another misuse of the global 'io' variable instead of the local 'base'.
>
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> ---
>   

This should be it. I did a search for 'io' in the entire driver and
found no other incorrect uses.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUIOA60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUIOA60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 20:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUIOA60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 20:58:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:18905 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266136AbUIOA6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 20:58:24 -0400
Date: Tue, 14 Sep 2004 18:02:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-ide@vger.kernel.org, Raphael Zimmerer <killekulla@rdrz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ide: remove obsolete CONFIG_BLK_DEV_ADMA - cleanup
 arch
Message-Id: <20040914180211.78b6085f.akpm@osdl.org>
In-Reply-To: <20040914095847.GG9994@rdrz.de>
References: <20040914095330.GF9994@rdrz.de>
	<20040914095847.GG9994@rdrz.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raphael Zimmerer <killekulla@rdrz.de> wrote:
>
> Cleans up default config for various archs, removing
> CONFIG_BLK_DEV_IDEPCI

I don't see much point in applying global defconfig sweeps, really. 
There's no end to it.

Obsolete paremeters do no real harm, and arch maintainers will
automatically eliminate obsolete stuff when they do their next defconfig
update.

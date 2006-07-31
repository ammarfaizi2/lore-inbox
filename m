Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbWGaTYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWGaTYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWGaTYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:24:47 -0400
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:30237 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1030347AbWGaTYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:24:46 -0400
Date: Mon, 31 Jul 2006 21:24:44 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix aty128_bl_set_power compile warning
Message-ID: <20060731192444.GA14449@hansmi.ch>
References: <20060731190022.GA5190@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731190022.GA5190@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 09:00:22PM +0200, Olaf Hering wrote:
> drivers/video/aty/aty128fb.c:458: warning: 'aty128_bl_set_power' declared 'static' but never defined

> Move the whole code block up and remove the static declaration.

Nack, already fixed by a patch that's awaiting inclusion by Linus.
Andrew sent it to him yesterday.

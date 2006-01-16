Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWAPOhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWAPOhG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 09:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWAPOhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 09:37:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39613 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750833AbWAPOhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 09:37:05 -0500
Subject: Re: [PATCH 3/3] omit symbol size field in print_symbol()
From: Arjan van de Ven <arjan@infradead.org>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060116121834.GD539@miraclelinux.com>
References: <20060116121611.GA539@miraclelinux.com>
	 <20060116121834.GD539@miraclelinux.com>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 15:37:01 +0100
Message-Id: <1137422221.3034.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-16 at 21:18 +0900, Akinobu Mita wrote:
> I can't find useful usage for the symbol size in print_symbol().
> And symbolsize seems to be fixed when vmlinux or modules are compiled.
> So we can calculate it from vmlinux or modules.


the use is that you can see if the EIP actually is inside the function,
or if the decoder is going bonkers. Quite useful feature that...



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVAaBfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVAaBfd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 20:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVAaBfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 20:35:32 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:44735 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261887AbVAaBf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 20:35:29 -0500
Subject: Re: inter-module-* removal.. small next step
From: David Woodhouse <dwmw2@infradead.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       bunk@stusta.de
In-Reply-To: <9e4733910501301654306c0d87@mail.gmail.com>
References: <20050130180016.GA12987@infradead.org>
	 <1107132112.783.219.camel@baythorne.infradead.org>
	 <9e4733910501301654306c0d87@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 31 Jan 2005 01:35:28 +0000
Message-Id: <1107135328.783.222.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-30 at 19:54 -0500, Jon Smirl wrote:
> Are these things old enough to just be marked broken instead and
> finish removing inter_xx?

The DiskOnChip drivers are getting that way; not the NOR flash drivers
though. Those need the problem solving properly; just hacking out the
inter_module_ crap and replacing it without thinking too hard isn't the
answer. I'll be glad to see the back of it though -- I was annoyed
enough when it was done in the first place, against my wishes.

-- 
dwmw2



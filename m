Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWDPRuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWDPRuX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 13:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWDPRuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 13:50:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59589 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750773AbWDPRuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 13:50:21 -0400
Subject: Re: [RFC: 2.6 patch] net/irda/irias_object.c: remove unused exports
From: Arjan van de Ven <arjan@infradead.org>
To: jt@hpl.hp.com
Cc: Adrian Bunk <bunk@stusta.de>, Samuel.Ortiz@nokia.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060414164203.GA24146@bougret.hpl.hp.com>
References: <20060414114446.GL4162@stusta.de>
	 <20060414164203.GA24146@bougret.hpl.hp.com>
Content-Type: text/plain
Date: Sun, 16 Apr 2006 19:46:50 +0200
Message-Id: <1145209616.3809.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	Personally, I don't see what this patch buy us...

all the unused exports in the kernel together make a binary kernel 100Kb
bigger. It's a case of a lot of little steps I suppose (each export
taking like 100 to 150 bytes depending on the size of the function name)


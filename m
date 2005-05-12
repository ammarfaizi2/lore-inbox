Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVELJnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVELJnV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 05:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVELJnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 05:43:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58308 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261370AbVELJnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 05:43:07 -0400
Subject: Re: [RFC/PATCH 0/5] add execute in place support
From: David Woodhouse <dwmw2@infradead.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Carsten Otte <cotte@freenet.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org
In-Reply-To: <20050512085741.GA16361@wohnheim.fh-wedel.de>
References: <428216DF.8070205@de.ibm.com>
	 <1115828389.16187.544.camel@hades.cambridge.redhat.com>
	 <42823450.8030007@freenet.de> <20050512085741.GA16361@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 May 2005 10:43:00 +0100
Message-Id: <1115890981.16187.553.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-12 at 10:57 +0200, Jörn Engel wrote:
> In principle, both the block device abstraction and the mtd
> abstraction fit your bill.  But jffs2 doesn't, so no in-kernel fs
> could make use of a xip-aware mtd abstraction.
> 
> Patching jffs2 for xip looks like a major effort, at best, and utterly
> insane at worst.  I'd prefer not to go down that path.

You and me both. The time has definitely come to recognise that JFFS2
needs replacing ;)

-- 
dwmw2


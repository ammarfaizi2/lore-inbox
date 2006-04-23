Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWDWHJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWDWHJl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 03:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWDWHJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 03:09:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10638 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751348AbWDWHJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 03:09:40 -0400
Subject: Re: [PATCH] 'make headers_install' kbuild target.
From: Arjan van de Ven <arjan@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, sam@ravnborg.org, mschwid2@de.ibm.com
In-Reply-To: <200604222313.42976.arnd@arndb.de>
References: <1145672241.16166.156.camel@shinybook.infradead.org>
	 <20060422132032.GB5010@stusta.de>
	 <1145719812.11909.333.camel@pmac.infradead.org>
	 <200604222313.42976.arnd@arndb.de>
Content-Type: text/plain
Date: Sun, 23 Apr 2006 09:09:30 +0200
Message-Id: <1145776170.3131.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> atomic.h 

this one for sure isn't for userspace; simply because at least on x86 it
isn't atomic there (well depending on the phase of the moon) and for
some it can't be done at all.



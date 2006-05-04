Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWEDGz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWEDGz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 02:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWEDGz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 02:55:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34026 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751410AbWEDGz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 02:55:57 -0400
Subject: Re: [PATCH] symlink nesting level change
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, hpa@zytor.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20060503183554.87f0218d.akpm@osdl.org>
References: <14CFC56C96D8554AA0B8969DB825FEA0012B309B@chicken.machinevisionproducts.com>
	 <44580CF2.7070602@tlinx.org> <e3966u$dje$1@terminus.zytor.com>
	 <20060503030849.GZ27946@ftp.linux.org.uk>
	 <20060503183554.87f0218d.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 04 May 2006 08:55:49 +0200
Message-Id: <1146725750.3101.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But I guess as major distros are 2.6.16-based, this is a good time to make
> this change.

several major distros already had this set to 8 anyway :

and your argument that this is a behavior break... holds for any
improvement and new driver to the kernel as well.. at some point it's
"if you use the new behavior, don't assume you can go back without
losing it"



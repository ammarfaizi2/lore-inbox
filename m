Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWCZUlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWCZUlZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 15:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWCZUlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 15:41:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28295 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751544AbWCZUlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 15:41:24 -0500
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Bodo Eggert <7eggert@gmx.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20060326200826.GB3486@parisc-linux.org>
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz>
	 <1143402698.3055.28.camel@laptopd505.fenrus.org>
	 <20060326200826.GB3486@parisc-linux.org>
Content-Type: text/plain
Date: Sun, 26 Mar 2006 22:41:20 +0200
Message-Id: <1143405680.3055.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Everything has to support HCIL, even if it's through some kind of
> mapping. 

for now ;)
>  Yes, I know it might not make much *sense* for some
> transports, but we do need to support it.  

but at least we should support 64 bit luns etc then...
(there is padding space.. so it can even be done in the same struct)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWD0Sa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWD0Sa5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWD0Sa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:30:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15335 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964950AbWD0Sa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:30:56 -0400
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <20060427182306.GL3570@stusta.de>
References: <1146049414.7016.9.camel@laptopd505.fenrus.org>
	 <20060426110656.GD29108@wohnheim.fh-wedel.de>
	 <Pine.LNX.4.58.0604270853510.20454@sbz-30.cs.Helsinki.FI>
	 <445061DC.5030008@yahoo.com.au>
	 <Pine.LNX.4.58.0604270926380.20454@sbz-30.cs.Helsinki.FI>
	 <1146120640.2894.1.camel@laptopd505.fenrus.org>
	 <20060427083157.GD3570@stusta.de>
	 <1146127273.2894.21.camel@laptopd505.fenrus.org>
	 <20060427085614.GE3570@stusta.de>
	 <1146128885.2894.27.camel@laptopd505.fenrus.org>
	 <20060427182306.GL3570@stusta.de>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 20:29:48 +0200
Message-Id: <1146162588.2894.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But for using your suggested "separate kfree() which does check out of 
> line" for not having the (otherwise unavoidable) space increast, we have 
> to manually change kfree() callers.

I don't follow you. Sorry.



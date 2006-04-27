Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWD0G2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWD0G2R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 02:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWD0G2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 02:28:17 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:2520 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964962AbWD0G2Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 02:28:16 -0400
Date: Thu, 27 Apr 2006 09:28:14 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>,
       Arjan van de Ven <arjan@infradead.org>, Hua Zhong <hzhong@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
In-Reply-To: <445061DC.5030008@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0604270926380.20454@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain>
 <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com>
 <1146038324.5956.0.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI>
 <1146040038.7016.0.camel@laptopd505.fenrus.org> <20060426100559.GC29108@wohnheim.fh-wedel.de>
 <1146046118.7016.5.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI>
 <1146049414.7016.9.camel@laptopd505.fenrus.org> <20060426110656.GD29108@wohnheim.fh-wedel.de>
 <Pine.LNX.4.58.0604270853510.20454@sbz-30.cs.Helsinki.FI> <445061DC.5030008@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2006, Nick Piggin wrote:
> Not to dispute your conclusions or method, but I think doing a
> defconfig or your personal config might be more representative
> of % size increase of text that will actually be executed. And
> that is the expensive type of text.

True but I was under the impression that Arjan thought we'd get text 
savings with GCC 4.1 by making kfree() inline.

				Pekka

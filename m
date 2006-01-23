Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWAWQwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWAWQwK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWAWQwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:52:10 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:34749 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964799AbWAWQwJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:52:09 -0500
Subject: Re: [PATCH] slab: Adds two missing kmalloc() checks.
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1138034695.2977.48.camel@laptopd505.fenrus.org>
References: <20060123133121.70f2cbcb.lcapitulino@mandriva.com.br>
	 <1138034316.10527.2.camel@localhost>
	 <1138034695.2977.48.camel@laptopd505.fenrus.org>
Date: Mon, 23 Jan 2006 18:52:02 +0200
Message-Id: <1138035122.10527.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 18:38 +0200, Pekka Enberg wrote:
> > Looks good to me. Arjan, you had some objections last time around. Are
> > you okay with the change?

On Mon, 2006-01-23 at 17:44 +0100, Arjan van de Ven wrote:
> I still fail to see the point. Has anyone EVER seen these trigger????

Yeah, we probably won't. They seem useful for people who hunt unchecked
kmalloc() calls, though.

			Pekka


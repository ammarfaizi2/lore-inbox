Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTFJWxT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 18:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTFJWxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 18:53:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27405 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261808AbTFJWxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 18:53:15 -0400
Date: Tue, 10 Jun 2003 16:06:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Olien <dmo@osdl.org>
cc: Steven Cole <elenstev@mesatop.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sparse type checking on function pointers
In-Reply-To: <20030610230318.GA10106@osdl.org>
Message-ID: <Pine.LNX.4.44.0306101604150.2044-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Jun 2003, Dave Olien wrote:
>
> I find it really easy to just over-ride this on the make command line:
> 
> 	make CHECK=/dmo_local/BK_TREES/sparse_original/check C=1

Yeah. That said, I agree with the complaint and there really is no excuse 
for the bad default values except for me being a lazy bastard. So I'm 
checking in a "make install" target for sparse, and I'll make the default 
CHECK binary be "sparse".

		Linus


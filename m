Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSIXHYk>; Tue, 24 Sep 2002 03:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbSIXHYk>; Tue, 24 Sep 2002 03:24:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15232 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261599AbSIXHYj>;
	Tue, 24 Sep 2002 03:24:39 -0400
Date: Tue, 24 Sep 2002 09:38:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "David S. Miller" <davem@redhat.com>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] streq() 
In-Reply-To: <20020924072814.CFC332C1AC@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209240937280.10708-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i think the high gfp bit idea sounds good. 95% of the gfp()/kmalloc()  
users use a static flag, so it's not like there is any widespread runtime
cost.

	Ingo


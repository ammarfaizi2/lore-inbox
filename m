Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319025AbSIDC5J>; Tue, 3 Sep 2002 22:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319024AbSIDC5J>; Tue, 3 Sep 2002 22:57:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55769 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319023AbSIDC5J>;
	Tue, 3 Sep 2002 22:57:09 -0400
Date: Tue, 03 Sep 2002 19:54:55 -0700 (PDT)
Message-Id: <20020903.195455.117344683.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       davem@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020904023535.73D922C12D@lists.samba.org>
References: <20020904023535.73D922C12D@lists.samba.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Wed, 04 Sep 2002 12:35:41 +1000

   This might explain the wierd per-cpu problem reports from Andrew and
   Dave, and also that nagging feeling that I'm an idiot...

Verifying...  no without the explicit initializers the per-cpu stuff
still ends up in the BSS with egcs-2.9X, even with your fix applied.

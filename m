Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319055AbSIDFH2>; Wed, 4 Sep 2002 01:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319056AbSIDFH2>; Wed, 4 Sep 2002 01:07:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50906 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319053AbSIDFH1>;
	Wed, 4 Sep 2002 01:07:27 -0400
Date: Tue, 03 Sep 2002 22:05:14 -0700 (PDT)
Message-Id: <20020903.220514.21399526.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix. 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020904042036.816A62C1B6@lists.samba.org>
References: <20020903.195455.117344683.davem@redhat.com>
	<20020904042036.816A62C1B6@lists.samba.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Wed, 04 Sep 2002 14:04:22 +1000

   OK.  I really hate working around wierd toolchain bugs (I use 2.95.4
   here and it's fine), and adding an initializer to the macro is ugly.
   
Mine is 2.92.11

   If you're not going to upgrade your compiler, will you accept a gcc
   patch to fix this?  If so, where can I get the source to your exact
   version?
   
Oh, "I'm" willing to upgrade "my" compiler, it's my users
that are the problem.  If you impose 3.1 or whatever, I get less
people testing on sparc64 as a result.

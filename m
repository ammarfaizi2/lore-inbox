Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264580AbSIQVDm>; Tue, 17 Sep 2002 17:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264592AbSIQVDm>; Tue, 17 Sep 2002 17:03:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16515 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264580AbSIQVDl>;
	Tue, 17 Sep 2002 17:03:41 -0400
Date: Tue, 17 Sep 2002 13:59:39 -0700 (PDT)
Message-Id: <20020917.135939.52477700.davem@redhat.com>
To: manfred@colorfullife.com
Cc: linux-netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Info: NAPI performance at "low" loads
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D87881F.4070808@colorfullife.com>
References: <3D87881F.4070808@colorfullife.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Manfred Spraul <manfred@colorfullife.com>
   Date: Tue, 17 Sep 2002 21:53:03 +0200

   Receiver:
     $ loadtest

This appears to be x86 only, sorry I can't test this out for you as
all my boxes are sparc64.

I was actually eager to try your tests out here.

Do you really need to use x86 instructions to do what you
are doing?  There are portable pthread mutexes available.

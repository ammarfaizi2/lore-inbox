Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317400AbSIBGWX>; Mon, 2 Sep 2002 02:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSIBGWX>; Mon, 2 Sep 2002 02:22:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5065 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317400AbSIBGWX>;
	Mon, 2 Sep 2002 02:22:23 -0400
Date: Sun, 01 Sep 2002 23:20:21 -0700 (PDT)
Message-Id: <20020901.232021.00308364.davem@redhat.com>
To: wli@holomorphy.com
Cc: rml@tech9.net, rusty@rustcorp.com.au, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020902060257.GO888@holomorphy.com>
References: <20020902003318.7CB682C092@lists.samba.org>
	<1030945918.939.3143.camel@phantasy>
	<20020902060257.GO888@holomorphy.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Lee Irwin III <wli@holomorphy.com>
   Date: Sun, 1 Sep 2002 23:02:57 -0700
   
   On Mon, Sep 02, 2002 at 01:51:54AM -0400, Robert Love wrote:
   > I am all for your cleanup here, but two nits:
   > Why not rename list_head while at it?  I would vote for just "struct
   > list" ... the name is long, and I like my lines to fit 80 columns.
   
   Seconded. Throw the whole frog in the blender, please, not just half.

The problem is, it isn't a "list", it's a "list header" or "list
marker", ie. a list_head.

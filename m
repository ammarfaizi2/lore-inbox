Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261612AbSJQBOn>; Wed, 16 Oct 2002 21:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261613AbSJQBOm>; Wed, 16 Oct 2002 21:14:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59318 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261612AbSJQBOm>;
	Wed, 16 Oct 2002 21:14:42 -0400
Date: Wed, 16 Oct 2002 18:12:13 -0700 (PDT)
Message-Id: <20021016.181213.35446337.davem@redhat.com>
To: levon@movementarian.org
Cc: weigand@immd1.informatik.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021017011623.GA9096@compsoc.man.ac.uk>
References: <20021017005728.GA8267@compsoc.man.ac.uk>
	<20021016.175515.21904896.davem@redhat.com>
	<20021017011623.GA9096@compsoc.man.ac.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: John Levon <levon@movementarian.org>
   Date: Thu, 17 Oct 2002 02:16:23 +0100

   On Wed, Oct 16, 2002 at 05:55:15PM -0700, David S. Miller wrote:
   
   > True.
   > 
   > What if you could query the cookie size at runtime?
   
   Not sure what you mean here. The cookie is passed in the syscall, so has
   to be fixed-size no matter what, right ?
   
Right, but you could zero-extend that from u32 if u32
were the size appropriate for the current kernel.

I'm trying to decrease the size of your logfile.

Franks a lot,
David S. Miller
davem@redhat.com
